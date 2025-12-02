import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  // DigitalOcean-inspired Light Theme
  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      // Primary - DigitalOcean Blue
      primary: Color(0xFF0069FF),
      surfaceTint: Color(0xFF0069FF),
      onPrimary: Color(0xFFFFFFFF),
      primaryContainer: Color(0xFF338FFF), // primaryLight
      onPrimaryContainer: Color(0xFF0050D4), // primaryDark
      // Secondary - Success Green
      secondary: Color(0xFF00C851),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFE8F5E9),
      onSecondaryContainer: Color(0xFF1B5E20),
      // Tertiary - Info Blue
      tertiary: Color(0xFF33B5E5),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFE1F5FE),
      onTertiaryContainer: Color(0xFF01579B),
      // Error - DigitalOcean Red
      error: Color(0xFFFF3547),
      onError: Color(0xFFFFFFFF),
      errorContainer: Color(0xFFFFEBEE),
      onErrorContainer: Color(0xFFB71C1C),
      // Surfaces - Light gray palette
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF171923), // gray900
      onSurfaceVariant: Color(0xFF4A5568), // gray600
      outline: Color(0xFFA0AEC0), // gray400
      outlineVariant: Color(0xFFE2E8F0), // gray200
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFF2D3748), // gray700
      inversePrimary: Color(0xFF338FFF),
      // Fixed colors
      primaryFixed: Color(0xFF338FFF),
      onPrimaryFixed: Color(0xFFFFFFFF),
      primaryFixedDim: Color(0xFF0069FF),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF00C851),
      onSecondaryFixed: Color(0xFFFFFFFF),
      secondaryFixedDim: Color(0xFF00A844),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF33B5E5),
      onTertiaryFixed: Color(0xFFFFFFFF),
      tertiaryFixedDim: Color(0xFF0099CC),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      // Surface containers
      surfaceDim: Color(0xFFEDF2F7), // gray100
      surfaceBright: Color(0xFFFFFFFF),
      surfaceContainerLowest: Color(0xFFFFFFFF),
      surfaceContainerLow: Color(0xFFF7FAFC), // gray50
      surfaceContainer: Color(0xFFEDF2F7), // gray100
      surfaceContainerHigh: Color(0xFFE2E8F0), // gray200
      surfaceContainerHighest: Color(0xFFCBD5E0), // gray300
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  // DigitalOcean-inspired Dark Theme
  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      // Primary - DigitalOcean Blue (lighter for dark mode)
      primary: Color(0xFF338FFF),
      surfaceTint: Color(0xFF338FFF),
      onPrimary: Color(0xFF0050D4),
      primaryContainer: Color(0xFF0069FF),
      onPrimaryContainer: Color(0xFFFFFFFF),
      // Secondary - Success Green
      secondary: Color(0xFF00C851),
      onSecondary: Color(0xFF1B5E20),
      secondaryContainer: Color(0xFF00A844),
      onSecondaryContainer: Color(0xFFE8F5E9),
      // Tertiary - Info Blue
      tertiary: Color(0xFF33B5E5),
      onTertiary: Color(0xFF01579B),
      tertiaryContainer: Color(0xFF0099CC),
      onTertiaryContainer: Color(0xFFE1F5FE),
      // Error - DigitalOcean Red (adjusted for dark)
      error: Color(0xFFFF6B7A),
      onError: Color(0xFFB71C1C),
      errorContainer: Color(0xFFFF3547),
      onErrorContainer: Color(0xFFFFEBEE),
      // Surfaces - Dark gray palette
      surface: Color(0xFF1A202C), // dark50
      onSurface: Color(0xFFFFFFFF),
      onSurfaceVariant: Color(0xFFA0AEC0), // gray400
      outline: Color(0xFF718096), // gray500
      outlineVariant: Color(0xFF4A5568), // gray600
      shadow: Color(0xFF000000),
      scrim: Color(0xFF000000),
      inverseSurface: Color(0xFFEDF2F7), // gray100
      inversePrimary: Color(0xFF0069FF),
      // Fixed colors
      primaryFixed: Color(0xFF338FFF),
      onPrimaryFixed: Color(0xFF1A202C),
      primaryFixedDim: Color(0xFF0069FF),
      onPrimaryFixedVariant: Color(0xFFFFFFFF),
      secondaryFixed: Color(0xFF00C851),
      onSecondaryFixed: Color(0xFF1A202C),
      secondaryFixedDim: Color(0xFF00A844),
      onSecondaryFixedVariant: Color(0xFFFFFFFF),
      tertiaryFixed: Color(0xFF33B5E5),
      onTertiaryFixed: Color(0xFF1A202C),
      tertiaryFixedDim: Color(0xFF0099CC),
      onTertiaryFixedVariant: Color(0xFFFFFFFF),
      // Surface containers
      surfaceDim: Color(0xFF171923), // gray900
      surfaceBright: Color(0xFF2D3748), // dark100/gray700
      surfaceContainerLowest: Color(0xFF171923), // gray900
      surfaceContainerLow: Color(0xFF1A202C), // dark50
      surfaceContainer: Color(0xFF2D3748), // dark100
      surfaceContainerHigh: Color(0xFF4A5568), // dark200/gray600
      surfaceContainerHighest: Color(0xFF718096), // dark300/gray500
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
    useMaterial3: true,
    brightness: colorScheme.brightness,
    colorScheme: colorScheme,
    textTheme: textTheme.apply(
      bodyColor: colorScheme.onSurface,
      displayColor: colorScheme.onSurface,
    ),
    scaffoldBackgroundColor: colorScheme.surface,
    canvasColor: colorScheme.surface,
  );

  List<ExtendedColor> get extendedColors => [];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
