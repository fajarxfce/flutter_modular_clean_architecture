#!/usr/bin/env dart

import 'dart:io';

void main(List<String> args) async {
  final cleanFlag = args.contains('--clean');
  final watchFlag = args.contains('--watch');

  print('🔨 Running build_runner in all packages...\n');

  final rootDir = Directory.current;
  final packagesDir = Directory('${rootDir.path}/packages');

  if (!packagesDir.existsSync()) {
    print('❌ packages directory not found!');
    exit(1);
  }

  // Find all packages with build_runner
  final packageDirs = <Directory>[];
  await for (final entity in packagesDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('pubspec.yaml')) {
      final content = await entity.readAsString();
      if (content.contains('build_runner')) {
        packageDirs.add(entity.parent);
      }
    }
  }

  print('📦 Found ${packageDirs.length} packages with build_runner:\n');

  var successCount = 0;
  var failCount = 0;

  for (final packageDir in packageDirs) {
    final packageName = packageDir.path.split('/').last;

    final command = cleanFlag
        ? 'clean'
        : watchFlag
        ? 'watch --delete-conflicting-outputs'
        : 'build --delete-conflicting-outputs';

    print('  🔨 Running build_runner $command in $packageName...');

    final result = await Process.run('dart', [
      'run',
      'build_runner',
      ...command.split(' '),
    ], workingDirectory: packageDir.path);

    if (result.exitCode == 0) {
      print('     ✅ Success\n');
      successCount++;
    } else {
      print('     ❌ Failed: ${result.stderr}\n');
      failCount++;
    }
  }

  // Run build_runner in root if it has build_runner
  final rootPubspec = File('${rootDir.path}/pubspec.yaml');
  if (rootPubspec.existsSync()) {
    final content = await rootPubspec.readAsString();
    if (content.contains('build_runner')) {
      print('  🔨 Running build_runner in root...');

      final command = cleanFlag
          ? 'clean'
          : watchFlag
          ? 'watch --delete-conflicting-outputs'
          : 'build --delete-conflicting-outputs';

      final result = await Process.run('dart', [
        'run',
        'build_runner',
        ...command.split(' '),
      ], workingDirectory: rootDir.path);

      if (result.exitCode == 0) {
        print('     ✅ Success\n');
        successCount++;
      } else {
        print('     ❌ Failed: ${result.stderr}\n');
        failCount++;
      }
    }
  }

  print('═' * 50);
  print('✨ Build completed!');
  print('   ✅ Success: $successCount packages');
  if (failCount > 0) {
    print('   ❌ Failed: $failCount packages');
  }
  print('═' * 50);
}
