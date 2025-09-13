import 'package:flutter/material.dart';
import '../constants/app_colours.dart';
import '../constants/app_styles.dart';
import '../utils/helpers.dart';

enum ButtonType { primary, secondary, outline, text, icon }
enum ButtonSize { small, medium, large }

class CustomButton extends StatefulWidget {
  final String? text;
  final IconData? icon;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final bool isFullWidth;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? borderColor;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Widget? leadingIcon;
  final Widget? trailingIcon;
  final bool enabled;
  final double? elevation;

  const CustomButton({
    super.key,
    this.text,
    this.icon,
    required this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.isFullWidth = false,
    this.backgroundColor,
    this.textColor,
    this.borderColor,
    this.padding,
    this.borderRadius,
    this.leadingIcon,
    this.trailingIcon,
    this.enabled = true,
    this.elevation,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: AppStyles.shortAnimation,
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: _buildButton(context),
        );
      },
    );
  }

  Widget _buildButton(BuildContext context) {
    final isDisabled = !widget.enabled || widget.onPressed == null;
    
    switch (widget.type) {
      case ButtonType.primary:
        return _buildPrimaryButton(context, isDisabled);
      case ButtonType.secondary:
        return _buildSecondaryButton(context, isDisabled);
      case ButtonType.outline:
        return _buildOutlineButton(context, isDisabled);
      case ButtonType.text:
        return _buildTextButton(context, isDisabled);
      case ButtonType.icon:
        return _buildIconButton(context, isDisabled);
    }
  }

  Widget _buildPrimaryButton(BuildContext context, bool isDisabled) {
    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      height: _getButtonHeight(),
      decoration: BoxDecoration(
        gradient: isDisabled 
            ? null 
            : (widget.backgroundColor != null 
                ? Helpers.generateGradient(widget.backgroundColor!)
                : AppColors.primaryGradient),
        color: isDisabled ? AppColors.buttonDisabled : widget.backgroundColor,
        borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
        boxShadow: isDisabled || widget.elevation == 0 
            ? null 
            : [
                BoxShadow(
                  color: (widget.backgroundColor ?? AppColors.primaryGreen)
                      .withValues(alpha: 0.3),
                  blurRadius: widget.elevation ?? 8,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : _handleTap,
          onTapDown: isDisabled ? null : (_) => _animationController.forward(),
          onTapUp: isDisabled ? null : (_) => _animationController.reverse(),
          onTapCancel: isDisabled ? null : () => _animationController.reverse(),
          borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
          child: Container(
            padding: widget.padding ?? _getButtonPadding(),
            child: _buildButtonContent(
              context,
              widget.textColor ?? AppColors.white,
              isDisabled,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryButton(BuildContext context, bool isDisabled) {
    final backgroundColor = isDisabled 
        ? AppColors.buttonDisabled 
        : (widget.backgroundColor ?? AppColors.secondaryBlue);
    
    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      height: _getButtonHeight(),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
        boxShadow: isDisabled || widget.elevation == 0 
            ? null 
            : [
                BoxShadow(
                  color: backgroundColor.withValues(alpha: 0.3),
                  blurRadius: widget.elevation ?? 6,
                  offset: const Offset(0, 3),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : _handleTap,
          onTapDown: isDisabled ? null : (_) => _animationController.forward(),
          onTapUp: isDisabled ? null : (_) => _animationController.reverse(),
          onTapCancel: isDisabled ? null : () => _animationController.reverse(),
          borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
          child: Container(
            padding: widget.padding ?? _getButtonPadding(),
            child: _buildButtonContent(
              context,
              widget.textColor ?? AppColors.white,
              isDisabled,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOutlineButton(BuildContext context, bool isDisabled) {
    final borderColor = isDisabled 
        ? AppColors.buttonDisabled 
        : (widget.borderColor ?? widget.backgroundColor ?? AppColors.primaryGreen);
    
    return Container(
      width: widget.isFullWidth ? double.infinity : null,
      height: _getButtonHeight(),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isDisabled ? null : _handleTap,
          onTapDown: isDisabled ? null : (_) => _animationController.forward(),
          onTapUp: isDisabled ? null : (_) => _animationController.reverse(),
          onTapCancel: isDisabled ? null : () => _animationController.reverse(),
          borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
          child: Container(
            padding: widget.padding ?? _getButtonPadding(),
            child: _buildButtonContent(
              context,
              widget.textColor ?? borderColor,
              isDisabled,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextButton(BuildContext context, bool isDisabled) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isDisabled ? null : _handleTap,
        onTapDown: isDisabled ? null : (_) => _animationController.forward(),
        onTapUp: isDisabled ? null : (_) => _animationController.reverse(),
        onTapCancel: isDisabled ? null : () => _animationController.reverse(),
        borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
        child: Container(
          padding: widget.padding ?? _getButtonPadding(),
          child: _buildButtonContent(
            context,
            widget.textColor ?? 
                (isDisabled ? AppColors.textSecondary : AppColors.primaryGreen),
            isDisabled,
          ),
        ),
      ),
    );
  }

  Widget _buildIconButton(BuildContext context, bool isDisabled) {
    return Material(
      color: widget.backgroundColor ?? Colors.transparent,
      borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
      child: InkWell(
        onTap: isDisabled ? null : _handleTap,
        onTapDown: isDisabled ? null : (_) => _animationController.forward(),
        onTapUp: isDisabled ? null : (_) => _animationController.reverse(),
        onTapCancel: isDisabled ? null : () => _animationController.reverse(),
        borderRadius: widget.borderRadius ?? AppStyles.mediumBorderRadius,
        child: Container(
          width: _getButtonHeight(),
          height: _getButtonHeight(),
          padding: widget.padding ?? EdgeInsets.all(_getIconPadding()),
          child: widget.isLoading 
              ? _buildLoadingIndicator(
                  widget.textColor ?? 
                      (isDisabled ? AppColors.textSecondary : AppColors.primaryGreen)
                )
              : Icon(
                  widget.icon,
                  size: _getIconSize(),
                  color: widget.textColor ?? 
                      (isDisabled ? AppColors.textSecondary : AppColors.primaryGreen),
                ),
        ),
      ),
    );
  }

  Widget _buildButtonContent(BuildContext context, Color textColor, bool isDisabled) {
    if (widget.isLoading) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildLoadingIndicator(textColor),
          if (widget.text != null) ...[
            const SizedBox(width: 8),
            Text(
              'Loading...',
              style: _getTextStyle().copyWith(color: textColor),
            ),
          ],
        ],
      );
    }

    final children = <Widget>[];

    if (widget.leadingIcon != null) {
      children.add(widget.leadingIcon!);
      if (widget.text != null) children.add(const SizedBox(width: 8));
    }

    if (widget.text != null) {
      children.add(
        Text(
          widget.text!,
          style: _getTextStyle().copyWith(color: textColor),
          textAlign: TextAlign.center,
        ),
      );
    }

    if (widget.trailingIcon != null) {
      if (widget.text != null) children.add(const SizedBox(width: 8));
      children.add(widget.trailingIcon!);
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
  }

  Widget _buildLoadingIndicator(Color color) {
    return SizedBox(
      width: _getIconSize(),
      height: _getIconSize(),
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(color),
      ),
    );
  }

  void _handleTap() {
    Helpers.lightHaptic();
    widget.onPressed?.call();
  }

  double _getButtonHeight() {
    switch (widget.size) {
      case ButtonSize.small:
        return AppStyles.smallButtonHeight;
      case ButtonSize.medium:
        return AppStyles.mediumButtonHeight;
      case ButtonSize.large:
        return AppStyles.largeButtonHeight;
    }
  }

  EdgeInsetsGeometry _getButtonPadding() {
    switch (widget.size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 12, vertical: 6);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 16);
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ButtonSize.small:
        return AppStyles.smallIconSize;
      case ButtonSize.medium:
        return AppStyles.mediumIconSize;
      case ButtonSize.large:
        return AppStyles.largeIconSize;
    }
  }

  double _getIconPadding() {
    switch (widget.size) {
      case ButtonSize.small:
        return 6;
      case ButtonSize.medium:
        return 8;
      case ButtonSize.large:
        return 12;
    }
  }

  TextStyle _getTextStyle() {
    switch (widget.size) {
      case ButtonSize.small:
        return AppStyles.buttonTextSmall;
      case ButtonSize.medium:
        return AppStyles.buttonTextMedium;
      case ButtonSize.large:
        return AppStyles.buttonTextLarge;
    }
  }
}