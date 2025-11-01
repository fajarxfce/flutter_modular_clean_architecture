# Flutter Modular Clean Architecture

## Setup

### Prerequisites

- Flutter SDK >= 3.24.0
- Dart SDK >= 3.9.2

### Bootstrap (Install dependencies di semua packages)

```bash
dart tool/bootstrap.dart
```

### Build (Generate code dengan build_runner di semua packages)

```bash
# Build sekali
dart tool/build.dart

# Build + watch (auto-rebuild saat ada perubahan)
dart tool/build.dart --watch

# Clean generated files
dart tool/build.dart --clean
```

## Dependency Management

Project ini menggunakan `pubspec_overrides.yaml` di root untuk mengelola versi dependencies yang dipakai di semua packages.

### Menambah dependency baru di package

1. Tambahkan ke `pubspec.yaml` di package **tanpa versi**:

```yaml
dependencies:
  new_package: # tanpa versi
```

2. Tambahkan versi di `pubspec_overrides.yaml` di root:

```yaml
dependency_overrides:
  new_package: ^1.0.0
```

3. Jalankan bootstrap:

```bash
dart tool/bootstrap.dart
```

### Dependencies yang sudah di-manage:

- `flutter_bloc: ^9.1.1`
- `bloc: ^8.1.4`
- `get_it: ^8.2.0`
- `injectable: ^2.5.2`
- `auto_route: ^10.2.0`
- `equatable: ^2.0.7`
- `build_runner: ^2.10.1`
- `injectable_generator: ^2.9.0`
- `auto_route_generator: ^10.2.5`

## Useful Commands

> **Note:** This project uses **Melos 7.x.x** with **Pub Workspaces**. Configuration is in `pubspec.yaml` under the `melos:` key. All packages have `resolution: workspace` enabled.

### Melos Commands (Recommended)

```bash
# Bootstrap all packages (install deps + link)
melos bootstrap
# or: melos bs

# Build all packages with build_runner
melos run build

# Build specific presentation packages only
melos run build_presentation

# Watch mode (auto-rebuild)
melos run build_watch

# Clean generated files
melos run build_clean

# Run tests
melos run test

# Test only feature packages
melos run test_features

# Test only changed packages (for CI)
melos run test_changed

# Analyze code
melos run analyze

# Format code
melos run format

# Full quality check (format + analyze + test)
melos run check

# Quick check (format + analyze)
melos run check_quick

# === Run Application ===
# Run app in debug mode
melos run run

# Run on specific device
melos run run_android
melos run run_ios
melos run run_chrome
melos run run_linux

# Run in release mode
melos run run_release

# === Development Workflow ===
# Full dev setup (bootstrap + build + run)
melos run dev

# Quick dev (build + run)
melos run dev_quick
```

# List all packages (built-in command)

melos list

# List only private packages

melos list --private

# List only published packages

melos list --no-private

# List with details

melos list --long

# Show dependency graph

melos list --graph

# Get dependencies in all packages

melos run get

# Upgrade dependencies

melos run upgrade

# Check outdated packages

melos run outdated

# Clean all packages

melos run clean

# Deep clean

melos run clean_deep

````

### Custom Scripts (Alternative)

```bash
# Bootstrap all packages (concurrent)
dart tool/bootstrap.dart

# Build all packages (concurrent)
dart tool/build.dart

# Build with watch mode
dart tool/build.dart --watch

# Clean generated files
dart tool/build.dart --clean

# Benchmark sequential vs concurrent
dart tool/benchmark.dart
````

### Direct Commands

```bash
# Format code
dart format .

# Run app
flutter run

# Run in root
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

## Tips

- **Jangan tambah versi di pubspec.yaml packages** - semua versi di-manage di `pubspec_overrides.yaml` root
- **Selalu jalankan bootstrap** setelah menambah/ubah dependencies
- **Gunakan build watch** saat development untuk auto-generate code
- **Setiap feature punya DI config sendiri** yang dikumpulkan di root

## Troubleshooting

### Error: Could not find Provider<Bloc>

- Pastikan bloc sudah di-register di DI config
- Jalankan `dart tool/build.dart` untuk generate DI config
- Hot-restart app (bukan hot-reload)

### Error: Route not generated

- Pastikan page sudah dianotasi dengan `@RoutePage()`
- Import page di `app_router.dart`
- Jalankan `dart tool/build.dart`

### Dependencies tidak sinkron

- Jalankan `dart tool/bootstrap.dart`
- Cek `pubspec_overrides.yaml` untuk memastikan versi sudah didefinisikan
