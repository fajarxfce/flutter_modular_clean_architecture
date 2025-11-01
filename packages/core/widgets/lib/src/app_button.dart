import 'package:flutter/material.dart';

/// DigitalOcean-inspired color palette
class AppColors {
  // Primary - DigitalOcean Blue
  static const Color primary = Color(0xFF0069FF);
  static const Color primaryDark = Color(0xFF0050D4);
  static const Color primaryLight = Color(0xFF338FFF);

  // Secondary - Accent colors
  static const Color success = Color(0xFF00C851);
  static const Color warning = Color(0xFFFFBB33);
  static const Color error = Color(0xFFFF3547);
  static const Color info = Color(0xFF33B5E5);

  // Neutrals
  static const Color white = Color(0xFFFFFFFF);
  static const Color gray50 = Color(0xFFF7FAFC);
  static const Color gray100 = Color(0xFFEDF2F7);
  static const Color gray200 = Color(0xFFE2E8F0);
  static const Color gray300 = Color(0xFFCBD5E0);
  static const Color gray400 = Color(0xFFA0AEC0);
  static const Color gray500 = Color(0xFF718096);
  static const Color gray600 = Color(0xFF4A5568);
  static const Color gray700 = Color(0xFF2D3748);
  static const Color gray800 = Color(0xFF1A202C);
  static const Color gray900 = Color(0xFF171923);

  // Text colors
  static const Color textPrimary = gray900;
  static const Color textSecondary = gray600;
  static const Color textDisabled = gray400;
}

/// Button size presets
enum AppButtonSize {
  small, // height: 32
  medium, // height: 40 (default)
  large, // height: 48
}

/// Button variants
enum AppButtonVariant {
  primary, // Filled primary color
  secondary, // Outlined primary
  destructive, // Filled error color
  ghost, // Text only
  link, // Underlined text
}

/// DigitalOcean-style button component
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final IconData? icon;
  final bool isLoading;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  });

  // Named constructors for common variants
  const AppButton.primary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.primary;

  const AppButton.secondary({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.secondary;

  const AppButton.destructive({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.destructive;

  const AppButton.ghost({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.ghost;

  const AppButton.link({
    super.key,
    required this.text,
    this.onPressed,
    this.size = AppButtonSize.medium,
    this.icon,
    this.isLoading = false,
    this.fullWidth = false,
  }) : variant = AppButtonVariant.link;

  @override
  Widget build(BuildContext context) {
    final buttonHeight = _getHeight();
    final horizontalPadding = _getHorizontalPadding();
    final fontSize = _getFontSize();
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      height: buttonHeight,
      width: fullWidth ? double.infinity : null,
      child: _buildButton(
        context: context,
        isEnabled: isEnabled,
        horizontalPadding: horizontalPadding,
        fontSize: fontSize,
      ),
    );
  }

  Widget _buildButton({
    required BuildContext context,
    required bool isEnabled,
    required double horizontalPadding,
    required double fontSize,
  }) {
    switch (variant) {
      case AppButtonVariant.primary:
        return _buildPrimaryButton(
          context: context,
          isEnabled: isEnabled,
          horizontalPadding: horizontalPadding,
          fontSize: fontSize,
        );
      case AppButtonVariant.secondary:
        return _buildSecondaryButton(
          context: context,
          isEnabled: isEnabled,
          horizontalPadding: horizontalPadding,
          fontSize: fontSize,
        );
      case AppButtonVariant.destructive:
        return _buildDestructiveButton(
          context: context,
          isEnabled: isEnabled,
          horizontalPadding: horizontalPadding,
          fontSize: fontSize,
        );
      case AppButtonVariant.ghost:
        return _buildGhostButton(
          context: context,
          isEnabled: isEnabled,
          horizontalPadding: horizontalPadding,
          fontSize: fontSize,
        );
      case AppButtonVariant.link:
        return _buildLinkButton(
          context: context,
          isEnabled: isEnabled,
          fontSize: fontSize,
        );
    }
  }

  Widget _buildPrimaryButton({
    required BuildContext context,
    required bool isEnabled,
    required double horizontalPadding,
    required double fontSize,
  }) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? AppColors.primary : AppColors.gray300,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.gray300,
        disabledForegroundColor: AppColors.textDisabled,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: _buildButtonContent(fontSize: fontSize, color: AppColors.white),
    );
  }

  Widget _buildSecondaryButton({
    required BuildContext context,
    required bool isEnabled,
    required double horizontalPadding,
    required double fontSize,
  }) {
    return OutlinedButton(
      onPressed: isEnabled ? onPressed : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: isEnabled ? AppColors.primary : AppColors.textDisabled,
        disabledForegroundColor: AppColors.textDisabled,
        side: BorderSide(
          color: isEnabled ? AppColors.primary : AppColors.gray300,
          width: 1.5,
        ),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: _buildButtonContent(
        fontSize: fontSize,
        color: isEnabled ? AppColors.primary : AppColors.textDisabled,
      ),
    );
  }

  Widget _buildDestructiveButton({
    required BuildContext context,
    required bool isEnabled,
    required double horizontalPadding,
    required double fontSize,
  }) {
    return ElevatedButton(
      onPressed: isEnabled ? onPressed : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: isEnabled ? AppColors.error : AppColors.gray300,
        foregroundColor: AppColors.white,
        disabledBackgroundColor: AppColors.gray300,
        disabledForegroundColor: AppColors.textDisabled,
        elevation: 0,
        shadowColor: Colors.transparent,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: _buildButtonContent(fontSize: fontSize, color: AppColors.white),
    );
  }

  Widget _buildGhostButton({
    required BuildContext context,
    required bool isEnabled,
    required double horizontalPadding,
    required double fontSize,
  }) {
    return TextButton(
      onPressed: isEnabled ? onPressed : null,
      style: TextButton.styleFrom(
        foregroundColor: isEnabled ? AppColors.primary : AppColors.textDisabled,
        disabledForegroundColor: AppColors.textDisabled,
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      child: _buildButtonContent(
        fontSize: fontSize,
        color: isEnabled ? AppColors.primary : AppColors.textDisabled,
      ),
    );
  }

  Widget _buildLinkButton({
    required BuildContext context,
    required bool isEnabled,
    required double fontSize,
  }) {
    return InkWell(
      onTap: isEnabled ? onPressed : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            color: isEnabled ? AppColors.primary : AppColors.textDisabled,
            decoration: TextDecoration.underline,
            decorationColor: isEnabled
                ? AppColors.primary
                : AppColors.textDisabled,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildButtonContent({required double fontSize, required Color color}) {
    if (isLoading) {
      return SizedBox(
        width: fontSize,
        height: fontSize,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      );
    }

    if (icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: fontSize * 1.2),
          const SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.3,
            ),
          ),
        ],
      );
    }

    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case AppButtonSize.small:
        return 32;
      case AppButtonSize.medium:
        return 40;
      case AppButtonSize.large:
        return 48;
    }
  }

  double _getHorizontalPadding() {
    switch (size) {
      case AppButtonSize.small:
        return 12;
      case AppButtonSize.medium:
        return 16;
      case AppButtonSize.large:
        return 20;
    }
  }

  double _getFontSize() {
    switch (size) {
      case AppButtonSize.small:
        return 13;
      case AppButtonSize.medium:
        return 14;
      case AppButtonSize.large:
        return 16;
    }
  }
}
