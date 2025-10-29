import 'package:flutter/material.dart';

/// Button size variants
enum SdsButtonSize {
  small,
  medium,
}

/// Button style variants
enum SdsButtonVariant {
  primary,
  neutral,
  subtle,
  dangerPrimary,
  dangerSubtle,
}

/// SDS Button Component
/// 
/// A Flutter implementation of the Simple Design System Button component.
/// Supports multiple variants (primary, neutral, subtle, danger-primary, danger-subtle)
/// and sizes (small, medium).
/// 
/// Example usage:
/// ```dart
/// SdsButton(
///   onPressed: () => print('Button pressed'),
///   variant: SdsButtonVariant.primary,
///   size: SdsButtonSize.medium,
///   child: Text('Click me'),
/// )
/// ```
class SdsButton extends StatefulWidget {
  /// The callback that is called when the button is pressed
  final VoidCallback? onPressed;
  
  /// The button's child widget (typically Text or Row with icon)
  final Widget child;
  
  /// The button size variant
  final SdsButtonSize size;
  
  /// The button style variant
  final SdsButtonVariant variant;
  
  /// Whether the button is disabled
  final bool isDisabled;
  
  /// Optional icon to display before the text
  final Widget? icon;
  
  /// Optional focus node
  final FocusNode? focusNode;
  
  /// Optional auto focus
  final bool autofocus;

  const SdsButton({
    Key? key,
    required this.child,
    this.onPressed,
    this.size = SdsButtonSize.medium,
    this.variant = SdsButtonVariant.primary,
    this.isDisabled = false,
    this.icon,
    this.focusNode,
    this.autofocus = false,
  }) : super(key: key);

  @override
  State<SdsButton> createState() => _SdsButtonState();
}

class _SdsButtonState extends State<SdsButton> {
  bool _isHovered = false;
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final bool effectivelyDisabled = widget.isDisabled || widget.onPressed == null;
    
    return Focus(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      onFocusChange: (focused) {
        setState(() {
          _isFocused = focused;
        });
      },
      child: MouseRegion(
        cursor: effectivelyDisabled 
            ? SystemMouseCursors.basic 
            : SystemMouseCursors.click,
        onEnter: effectivelyDisabled ? null : (_) {
          setState(() {
            _isHovered = true;
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered = false;
          });
        },
        child: GestureDetector(
          onTap: effectivelyDisabled ? null : widget.onPressed,
          child: Container(
            decoration: BoxDecoration(
              color: _getBackgroundColor(effectivelyDisabled),
              borderRadius: _getBorderRadius(),
              border: Border.all(
                color: _getBorderColor(effectivelyDisabled),
                width: 1.0,
              ),
              boxShadow: _isFocused ? [
                BoxShadow(
                  color: _getFocusRingColor(),
                  blurRadius: 0,
                  spreadRadius: 2,
                ),
              ] : null,
            ),
            padding: _getPadding(),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  IconTheme(
                    data: IconThemeData(
                      color: _getTextColor(effectivelyDisabled),
                      size: _getIconSize(),
                    ),
                    child: widget.icon!,
                  ),
                  SizedBox(width: 8), // --sds-size-space-200 (0.5rem = 8px)
                ],
                DefaultTextStyle(
                  style: TextStyle(
                    color: _getTextColor(effectivelyDisabled),
                    fontSize: _getFontSize(),
                    fontWeight: _getFontWeight(),
                    fontFamily: 'Inter',
                    height: 1.0,
                  ),
                  child: widget.child,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    // --sds-size-radius-200: 0.5rem = 8px
    return BorderRadius.circular(8.0);
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case SdsButtonSize.small:
        // --sds-size-space-200: 0.5rem = 8px
        return EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0);
      case SdsButtonSize.medium:
        // --sds-size-space-300: 0.75rem = 12px
        return EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0);
    }
  }

  double _getFontSize() {
    switch (widget.size) {
      case SdsButtonSize.small:
        // --sds-typography-scale-02: 0.875rem = 14px
        return 14.0;
      case SdsButtonSize.medium:
        // --sds-typography-scale-03: 1rem = 16px
        return 16.0;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case SdsButtonSize.small:
        return 14.0; // --sds-typography-scale-02
      case SdsButtonSize.medium:
        return 16.0; // --sds-typography-scale-03
    }
  }

  FontWeight _getFontWeight() {
    // --sds-typography-weight-regular: 400
    return FontWeight.w400;
  }

  Color _getBackgroundColor(bool isDisabled) {
    if (isDisabled) {
      // --sds-color-background-disabled-default
      return SdsColors.backgroundDisabledDefault;
    }

    switch (widget.variant) {
      case SdsButtonVariant.primary:
        return _isHovered
            ? SdsColors.backgroundBrandHover
            : SdsColors.backgroundBrandDefault;
      case SdsButtonVariant.neutral:
        return _isHovered
            ? SdsColors.backgroundDefaultSecondaryHover
            : SdsColors.backgroundDefaultSecondary;
      case SdsButtonVariant.subtle:
        return _isHovered
            ? SdsColors.backgroundDefaultDefaultHover
            : Colors.transparent;
      case SdsButtonVariant.dangerPrimary:
        return _isHovered
            ? SdsColors.backgroundDangerHover
            : SdsColors.backgroundDangerDefault;
      case SdsButtonVariant.dangerSubtle:
        return _isHovered
            ? SdsColors.backgroundDangerTertiaryHover
            : Colors.transparent;
    }
  }

  Color _getBorderColor(bool isDisabled) {
    if (isDisabled) {
      return SdsColors.borderDisabledDefault;
    }

    switch (widget.variant) {
      case SdsButtonVariant.primary:
        return SdsColors.borderBrandDefault;
      case SdsButtonVariant.neutral:
        return SdsColors.borderDefaultDefault;
      case SdsButtonVariant.subtle:
        return Colors.transparent;
      case SdsButtonVariant.dangerPrimary:
        return _isHovered
            ? SdsColors.borderDangerDefault
            : SdsColors.borderDangerSecondary;
      case SdsButtonVariant.dangerSubtle:
        return Colors.transparent;
    }
  }

  Color _getTextColor(bool isDisabled) {
    if (isDisabled) {
      return SdsColors.textDisabledDefault;
    }

    switch (widget.variant) {
      case SdsButtonVariant.primary:
        return SdsColors.textBrandOnBrand;
      case SdsButtonVariant.neutral:
        return SdsColors.textDefaultDefault;
      case SdsButtonVariant.subtle:
        return SdsColors.textBrandDefault;
      case SdsButtonVariant.dangerPrimary:
        return SdsColors.textDangerOnDanger;
      case SdsButtonVariant.dangerSubtle:
        return SdsColors.textDangerDefault;
    }
  }

  Color _getFocusRingColor() {
    // Using a blue focus ring color (could be made configurable)
    return Color(0xFF0066FF).withOpacity(0.5);
  }
}

/// SDS Button Group Component
/// 
/// A container for arranging multiple buttons with consistent spacing.
/// 
/// Example usage:
/// ```dart
/// SdsButtonGroup(
///   alignment: SdsButtonGroupAlignment.start,
///   children: [
///     SdsButton(child: Text('Cancel'), onPressed: () {}),
///     SdsButton(child: Text('Submit'), onPressed: () {}),
///   ],
/// )
/// ```
class SdsButtonGroup extends StatelessWidget {
  final List<Widget> children;
  final SdsButtonGroupAlignment alignment;

  const SdsButtonGroup({
    Key? key,
    required this.children,
    this.alignment = SdsButtonGroupAlignment.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12.0, // --sds-size-space-300: 0.75rem = 12px
      runSpacing: 12.0,
      alignment: _getWrapAlignment(),
      children: alignment == SdsButtonGroupAlignment.stack
          ? children
              .map((child) => SizedBox(width: double.infinity, child: child))
              .toList()
          : children,
    );
  }

  WrapAlignment _getWrapAlignment() {
    switch (alignment) {
      case SdsButtonGroupAlignment.start:
        return WrapAlignment.start;
      case SdsButtonGroupAlignment.center:
        return WrapAlignment.center;
      case SdsButtonGroupAlignment.end:
        return WrapAlignment.end;
      case SdsButtonGroupAlignment.justify:
        return WrapAlignment.spaceBetween;
      case SdsButtonGroupAlignment.stack:
        return WrapAlignment.start;
    }
  }
}

enum SdsButtonGroupAlignment {
  start,
  center,
  end,
  justify,
  stack,
}

/// SDS Color System
/// 
/// Color constants matching the SDS design tokens.
/// In a production app, these would ideally be loaded from theme configuration
/// or generated from the same source as the CSS variables.
class SdsColors {
  // Background colors - Brand
  static const Color backgroundBrandDefault = Color(0xFF2C2C2C); // --sds-color-brand-800
  static const Color backgroundBrandHover = Color(0xFF1E1E1E); // --sds-color-brand-900
  static const Color backgroundBrandSecondary = Color(0xFFE6E6E6); // --sds-color-brand-200
  static const Color backgroundBrandSecondaryHover = Color(0xFFD9D9D9); // --sds-color-brand-300

  // Background colors - Default
  static const Color backgroundDefaultDefault = Color(0xFFFFFFFF); // --sds-color-white-1000
  static const Color backgroundDefaultDefaultHover = Color(0xFFF5F5F5); // --sds-color-gray-100
  static const Color backgroundDefaultSecondary = Color(0xFFF5F5F5); // --sds-color-gray-100
  static const Color backgroundDefaultSecondaryHover = Color(0xFFE6E6E6); // --sds-color-gray-200

  // Background colors - Danger
  static const Color backgroundDangerDefault = Color(0xFFEC221F); // --sds-color-red-500
  static const Color backgroundDangerHover = Color(0xFFC00F0C); // --sds-color-red-600
  static const Color backgroundDangerTertiaryHover = Color(0xFFFDD3D0); // --sds-color-red-200

  // Background colors - Disabled
  static const Color backgroundDisabledDefault = Color(0xFFD9D9D9); // --sds-color-brand-300

  // Border colors
  static const Color borderBrandDefault = Color(0xFF2C2C2C); // --sds-color-brand-800
  static const Color borderDefaultDefault = Color(0xFFD9D9D9); // --sds-color-gray-300
  static const Color borderDangerDefault = Color(0xFF900B09); // --sds-color-red-700
  static const Color borderDangerSecondary = Color(0xFFC00F0C); // --sds-color-red-600
  static const Color borderDisabledDefault = Color(0xFFB3B3B3); // --sds-color-brand-400

  // Text colors
  static const Color textBrandOnBrand = Color(0xFFF5F5F5); // --sds-color-brand-100
  static const Color textBrandDefault = Color(0xFF2C2C2C); // --sds-color-brand-800
  static const Color textDefaultDefault = Color(0xFF1E1E1E); // --sds-color-gray-900
  static const Color textDangerOnDanger = Color(0xFFEBFFEE); // --sds-color-red-100
  static const Color textDangerDefault = Color(0xFF900B09); // --sds-color-red-700
  static const Color textDisabledDefault = Color(0xFFB3B3B3); // --sds-color-brand-400
}
