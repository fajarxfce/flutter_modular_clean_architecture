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

```bash
# Bootstrap all packages
dart tool/bootstrap.dart

# Build all packages
dart tool/build.dart

# Build with watch mode
dart tool/build.dart --watch

# Clean generated files
dart tool/build.dart --clean

# Format code
dart format .

# Run app
flutter run
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
