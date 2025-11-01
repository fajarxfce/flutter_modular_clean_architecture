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

  print('📦 Found ${pubspecFiles.length} packages\n');
  print('⚡ Running flutter pub get in parallel...\n');

  // Run flutter pub get in parallel
  final futures = pubspecFiles.map((pubspec) async {
    final packageDir = pubspec.parent;
    final packageName = packageDir.path.split('/').last;

    final result = await Process.run('flutter', [
      'pub',
      'get',
    ], workingDirectory: packageDir.path);

    return {
      'name': packageName,
      'success': result.exitCode == 0,
      'error': result.exitCode != 0 ? result.stderr.toString() : null,
    };
  }).toList();

  final results = await Future.wait(futures);

  // Print results
  var successCount = 0;
  var failCount = 0;

  for (final result in results) {
    final name = result['name'] as String;
    final success = result['success'] as bool;
    final error = result['error'] as String?;

    if (success) {
      print('  ✅ $name');
      successCount++;
    } else {
      print('  ❌ $name');
      if (error != null) {
        print('     Error: $error');
      }
      failCount++;
    }
  }

  print('\n' + '═' * 50);
  print('✨ Bootstrap completed!');
  print('   ✅ Success: $successCount packages');
  if (failCount > 0) {
    print('   ❌ Failed: $failCount packages');
  }
  print('═' * 50);
}
