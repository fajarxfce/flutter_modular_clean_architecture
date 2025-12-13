import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// TextField size presets
enum AppTextFieldSize {
  small, // height: 32
  medium, // height: 40 (default)
  large, // height: 48
}

/// TextField variants
enum AppTextFieldVariant {
  outlined, // Default with border
  filled, // Filled background
}

/// DigitalOcean-style text field component
class AppTextField extends StatefulWidget {
  final String? label;
  final String? placeholder;
  final String? helperText;
  final String? errorText;
  final TextEditingController? controller;
  final String? initialValue;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obscureText;
  final bool enabled;
  final bool readOnly;
  final int? maxLines;
  final int? minLines;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final AppTextFieldSize size;
  final AppTextFieldVariant variant;
  final bool autofocus;
  final String? prefixText;
  final String? suffixText;
  final TextCapitalization textCapitalization;

  const AppTextField({
    super.key,
    this.label,
    this.placeholder,
    this.helperText,
    this.errorText,
    this.controller,
    this.initialValue,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.obscureText = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.size = AppTextFieldSize.medium,
    this.variant = AppTextFieldVariant.outlined,
    this.autofocus = false,
    this.prefixText,
    this.suffixText,
    this.textCapitalization = TextCapitalization.none,
  });

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _isFocused = false; // ignore: unused_field

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
              letterSpacing: 0.2,
            ),
          ),
          const SizedBox(height: 6),
        ],
        SizedBox(
          height: _getHeight(),
          child: TextFormField(
            controller: widget.controller,
            initialValue: widget.initialValue,
            focusNode: _focusNode,
            onChanged: widget.onChanged,
            onEditingComplete: widget.onEditingComplete,
            onFieldSubmitted: widget.onSubmitted,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            obscureText: widget.obscureText,
            enabled: widget.enabled,
            readOnly: widget.readOnly,
            maxLines: widget.obscureText ? 1 : widget.maxLines,
            minLines: widget.minLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            autofocus: widget.autofocus,
            textCapitalization: widget.textCapitalization,
            style: TextStyle(
              fontSize: _getFontSize(),
              color: widget.enabled
                  ? colorScheme.onSurface
                  : colorScheme.onSurfaceVariant.withOpacity(0.38),
              fontWeight: FontWeight.w400,
            ),
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: TextStyle(
                fontSize: _getFontSize(),
                color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                fontWeight: FontWeight.w400,
              ),
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.suffixIcon,
              prefixText: widget.prefixText,
              suffixText: widget.suffixText,
              filled: widget.variant == AppTextFieldVariant.filled,
              fillColor: widget.variant == AppTextFieldVariant.filled
                  ? colorScheme.surfaceContainerLow
                  : null,
              contentPadding: EdgeInsets.symmetric(
                horizontal: _getHorizontalPadding(),
                vertical: _getVerticalPadding(),
              ),
              border: _getBorder(context, hasError: false, isFocused: false),
              enabledBorder: _getBorder(
                context,
                hasError: hasError,
                isFocused: false,
              ),
              focusedBorder: _getBorder(
                context,
                hasError: hasError,
                isFocused: true,
              ),
              errorBorder: _getBorder(
                context,
                hasError: true,
                isFocused: false,
              ),
              focusedErrorBorder: _getBorder(
                context,
                hasError: true,
                isFocused: true,
              ),
              disabledBorder: _getDisabledBorder(context),
              counterText: '', // Hide character counter
            ),
          ),
        ),
        if (widget.helperText != null && !hasError) ...[
          const SizedBox(height: 4),
          Text(
            widget.helperText!,
            style: TextStyle(
              fontSize: 12,
              color: colorScheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
        if (hasError) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.error_outline, size: 14, color: colorScheme.error),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  widget.errorText!,
                  style: TextStyle(
                    fontSize: 12,
                    color: colorScheme.error,
                    height: 1.4,
                  ),
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  InputBorder _getBorder(
    BuildContext context, {
    required bool hasError,
    required bool isFocused,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    Color borderColor;

    if (hasError) {
      borderColor = colorScheme.error;
    } else if (isFocused) {
      borderColor = colorScheme.primary;
    } else {
      borderColor = colorScheme.outline;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: borderColor, width: isFocused ? 1 : 1),
    );
  }

  InputBorder _getDisabledBorder(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide(
        color: colorScheme.outlineVariant.withOpacity(0.5),
        width: 1,
      ),
    );
  }

  double? _getHeight() {
    if (widget.maxLines != null && widget.maxLines! > 1) {
      return null; // Let TextField manage its own height for multiline
    }

    switch (widget.size) {
      case AppTextFieldSize.small:
        return 32;
      case AppTextFieldSize.medium:
        return 40;
      case AppTextFieldSize.large:
        return 48;
    }
  }

  double _getHorizontalPadding() {
    switch (widget.size) {
      case AppTextFieldSize.small:
        return 10;
      case AppTextFieldSize.medium:
        return 12;
      case AppTextFieldSize.large:
        return 16;
    }
  }

  double _getVerticalPadding() {
    if (widget.maxLines != null && widget.maxLines! > 1) {
      return 12;
    }

    switch (widget.size) {
      case AppTextFieldSize.small:
        return 6;
      case AppTextFieldSize.medium:
        return 8;
      case AppTextFieldSize.large:
        return 12;
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case AppTextFieldSize.small:
        return 13;
      case AppTextFieldSize.medium:
        return 14;
      case AppTextFieldSize.large:
        return 16;
    }
  }
}
