#!/usr/bin/env dart

import 'dart:io';

void main() async {
  print('🚀 Bootstrapping all packages...\n');

  final rootDir = Directory.current;
  final packagesDir = Directory('${rootDir.path}/packages');

  if (!packagesDir.existsSync()) {
    print('❌ packages directory not found!');
    exit(1);
  }

  // Find all pubspec.yaml files in packages
  final pubspecFiles = <File>[];
  await for (final entity in packagesDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('pubspec.yaml')) {
      pubspecFiles.add(entity);
    }
  }

  print('📦 Found ${pubspecFiles.length} packages:\n');

  var successCount = 0;
  var failCount = 0;

  for (final pubspec in pubspecFiles) {
    final packageDir = pubspec.parent;
    final packageName = packageDir.path.split('/').last;

    print('  📥 Getting dependencies for $packageName...');

    final result = await Process.run('flutter', [
      'pub',
      'get',
    ], workingDirectory: packageDir.path);

    if (result.exitCode == 0) {
      print('     ✅ Success\n');
      successCount++;
    } else {
      print('     ❌ Failed: ${result.stderr}\n');
      failCount++;
    }
  }

  print('═' * 50);
  print('✨ Bootstrap completed!');
  print('   ✅ Success: $successCount packages');
  if (failCount > 0) {
    print('   ❌ Failed: $failCount packages');
  }
  print('═' * 50);
}
