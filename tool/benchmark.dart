#!/usr/bin/env dart
// Script untuk compare kecepatan sequential vs concurrent

import 'dart:io';

void main() async {
  print('⏱️  Performance Test: Sequential vs Concurrent\n');

  final rootDir = Directory.current;
  final packagesDir = Directory('${rootDir.path}/packages');

  // Find all packages
  final pubspecFiles = <File>[];
  await for (final entity in packagesDir.list(recursive: true)) {
    if (entity is File && entity.path.endsWith('pubspec.yaml')) {
      pubspecFiles.add(entity);
    }
  }

  print('📦 Found ${pubspecFiles.length} packages\n');

  // Test Sequential
  print('🐌 Testing SEQUENTIAL execution...');
  final sequentialStart = DateTime.now();

  for (final pubspec in pubspecFiles) {
    final packageDir = pubspec.parent;
    await Process.run('flutter', [
      'pub',
      'get',
    ], workingDirectory: packageDir.path);
  }

  final sequentialDuration = DateTime.now().difference(sequentialStart);
  print(
    '   Time: ${sequentialDuration.inSeconds}s ${sequentialDuration.inMilliseconds % 1000}ms\n',
  );

  // Test Concurrent
  print('⚡ Testing CONCURRENT execution...');
  final concurrentStart = DateTime.now();

  final futures = pubspecFiles.map((pubspec) async {
    final packageDir = pubspec.parent;
    await Process.run('flutter', [
      'pub',
      'get',
    ], workingDirectory: packageDir.path);
  }).toList();

  await Future.wait(futures);

  final concurrentDuration = DateTime.now().difference(concurrentStart);
  print(
    '   Time: ${concurrentDuration.inSeconds}s ${concurrentDuration.inMilliseconds % 1000}ms\n',
  );

  // Calculate speedup
  final speedup =
      sequentialDuration.inMilliseconds / concurrentDuration.inMilliseconds;

  print('═' * 50);
  print('📊 Results:');
  print(
    '   Sequential: ${sequentialDuration.inSeconds}s ${sequentialDuration.inMilliseconds % 1000}ms',
  );
  print(
    '   Concurrent: ${concurrentDuration.inSeconds}s ${concurrentDuration.inMilliseconds % 1000}ms',
  );
  print('   Speedup: ${speedup.toStringAsFixed(2)}x faster! 🚀');
  print('═' * 50);
}
