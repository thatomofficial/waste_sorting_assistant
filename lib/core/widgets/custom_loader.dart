import 'dart:math';
import 'package:flutter/material.dart';
import '../constants/app_colours.dart';
import '../constants/app_styles.dart';

enum LoaderType { circular, linear, dots, pulse, wave }
enum LoaderSize { small, medium, large }

class CustomLoader extends StatefulWidget {
  final LoaderType type;
  final LoaderSize size;
  final Color? color;
  final String? message;
  final bool showBackground;
  final Color? backgroundColor;
  final double? strokeWidth;
  final Duration animationDuration;

  const CustomLoader({
    super.key,
    this.type = LoaderType.circular,
    this.size = LoaderSize.medium,
    this.color,
    this.message,
    this.showBackground = false,
    this.backgroundColor,
    this.strokeWidth,
    this.animationDuration = const Duration(milliseconds: 1000),
  });

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader>
    with TickerProviderStateMixin {
  late AnimationController _primaryController;
  late AnimationController _secondaryController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startAnimations();
  }

  void _setupAnimations() {
    _primaryController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _secondaryController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _primaryController,
      curve: Curves.linear,
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _secondaryController,
      curve: Curves.easeInOut,
    ));

    _opacityAnimation = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _secondaryController,
      curve: Curves.easeInOut,
    ));
  }

  void _startAnimations() {
    switch (widget.type) {
      case LoaderType.circular:
      case LoaderType.linear:
        _primaryController.repeat();
        break;
      case LoaderType.dots:
      case LoaderType.pulse:
        _primaryController.repeat();
        _secondaryController.repeat(reverse: true);
        break;
      case LoaderType.wave:
        _primaryController.repeat();
        _secondaryController.repeat();
        break;
    }
  }

  @override
  void dispose() {
    _primaryController.dispose();
    _secondaryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget loader;

    switch (widget.type) {
      case LoaderType.circular:
        loader = _buildCircularLoader();
        break;
      case LoaderType.linear:
        loader = _buildLinearLoader();
        break;
      case LoaderType.dots:
        loader = _buildDotsLoader();
        break;
      case LoaderType.pulse:
        loader = _buildPulseLoader();
        break;
      case LoaderType.wave:
        loader = _buildWaveLoader();
        break;
    }

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        loader,
        if (widget.message != null) ...[
          SizedBox(height: _getSpacing()),
          Text(
            widget.message!,
            style: _getMessageStyle(),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );

    if (widget.showBackground) {
      return Container(
        color: widget.backgroundColor ?? Colors.black.withOpacity(0.5),
        child: Center(child: content),
      );
    }

    return content;
  }

  Widget _buildCircularLoader() {
    return SizedBox(
      width: _getLoaderSize(),
      height: _getLoaderSize(),
      child: CircularProgressIndicator(
        strokeWidth: widget.strokeWidth ?? _getStrokeWidth(),
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.color ?? AppColors.primaryGreen,
        ),
      ),
    );
  }

  Widget _buildLinearLoader() {
    return Container(
      width: _getLoaderSize() * 2,
      height: _getStrokeWidth(),
      child: LinearProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          widget.color ?? AppColors.primaryGreen,
        ),
        backgroundColor: (widget.color ?? AppColors.primaryGreen).withOpacity(0.2),
      ),
    );
  }

  Widget _buildDotsLoader() {
    return AnimatedBuilder(
      animation: _primaryController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final delay = index * 0.2;
            final animationValue = (_primaryController.value - delay) % 1.0;
            final opacity = _calculateDotOpacity(animationValue);
            final scale = _calculateDotScale(animationValue);

            return Container(
              margin: EdgeInsets.symmetric(horizontal: _getSpacing() / 4),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  width: _getDotSize(),
                  height: _getDotSize(),
                  decoration: BoxDecoration(
                    color: (widget.color ?? AppColors.primaryGreen)
                        .withOpacity(opacity),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildPulseLoader() {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: 0.5 + (_scaleAnimation.value * 0.5),
          child: Container(
            width: _getLoaderSize(),
            height: _getLoaderSize(),
            decoration: BoxDecoration(
              color: widget.color ?? AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }

  Widget _buildWaveLoader() {
    return AnimatedBuilder(
      animation: _primaryController,
      builder: (context, child) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            final delay = index * 0.1;
            final animationValue = (_primaryController.value - delay) % 1.0;
            final height = _calculateWaveHeight(animationValue);

            return Container(
              margin: EdgeInsets.symmetric(horizontal: 1),
              child: Container(
                width: _getWaveBarWidth(),
                height: height,
                decoration: BoxDecoration(
                  color: widget.color ?? AppColors.primaryGreen,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  double _getLoaderSize() {
    switch (widget.size) {
      case LoaderSize.small:
        return 24.0;
      case LoaderSize.medium:
        return 32.0;
      case LoaderSize.large:
        return 48.0;
    }
  }

  double _getStrokeWidth() {
    switch (widget.size) {
      case LoaderSize.small:
        return 2.0;
      case LoaderSize.medium:
        return 3.0;
      case LoaderSize.large:
        return 4.0;
    }
  }

  double _getDotSize() {
    switch (widget.size) {
      case LoaderSize.small:
        return 6.0;
      case LoaderSize.medium:
        return 8.0;
      case LoaderSize.large:
        return 12.0;
    }
  }

  double _getWaveBarWidth() {
    switch (widget.size) {
      case LoaderSize.small:
        return 2.0;
      case LoaderSize.medium:
        return 3.0;
      case LoaderSize.large:
        return 4.0;
    }
  }

  double _getSpacing() {
    switch (widget.size) {
      case LoaderSize.small:
        return 8.0;
      case LoaderSize.medium:
        return 12.0;
      case LoaderSize.large:
        return 16.0;
    }
  }

  TextStyle _getMessageStyle() {
    switch (widget.size) {
      case LoaderSize.small:
        return AppStyles.bodySmall.copyWith(
          color: widget.color ?? AppColors.textSecondary,
        );
      case LoaderSize.medium:
        return AppStyles.bodyMedium.copyWith(
          color: widget.color ?? AppColors.textSecondary,
        );
      case LoaderSize.large:
        return AppStyles.bodyLarge.copyWith(
          color: widget.color ?? AppColors.textPrimary,
        );
    }
  }

  double _calculateDotOpacity(double animationValue) {
    if (animationValue < 0.0 || animationValue > 1.0) return 0.3;
    if (animationValue < 0.5) {
      return 0.3 + (animationValue * 2 * 0.7);
    } else {
      return 1.0 - ((animationValue - 0.5) * 2 * 0.7);
    }
  }

  double _calculateDotScale(double animationValue) {
    if (animationValue < 0.0 || animationValue > 1.0) return 0.8;
    if (animationValue < 0.5) {
      return 0.8 + (animationValue * 2 * 0.4);
    } else {
      return 1.2 - ((animationValue - 0.5) * 2 * 0.4);
    }
  }

  double _calculateWaveHeight(double animationValue) {
    if (animationValue < 0.0 || animationValue > 1.0) return _getLoaderSize() * 0.3;
    
    final normalizedValue = (sin(animationValue * pi * 2) + 1) / 2;
    final minHeight = _getLoaderSize() * 0.3;
    final maxHeight = _getLoaderSize();
    
    return minHeight + (normalizedValue * (maxHeight - minHeight));
  }
}

// Overlay Loader for full screen loading
class LoaderOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final String? message;
  final LoaderType loaderType;
  final LoaderSize loaderSize;
  final Color? loaderColor;
  final Color? overlayColor;

  const LoaderOverlay({
    super.key,
    required this.child,
    required this.isLoading,
    this.message,
    this.loaderType = LoaderType.circular,
    this.loaderSize = LoaderSize.medium,
    this.loaderColor,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: CustomLoader(
              type: loaderType,
              size: loaderSize,
              color: loaderColor,
              message: message,
              showBackground: true,
              backgroundColor: overlayColor,
            ),
          ),
      ],
    );
  }
}

// Button with integrated loader
class LoaderButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final LoaderSize loaderSize;
  final Color? loaderColor;
  final ButtonStyle? style;
  final Widget? icon;

  const LoaderButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.loaderSize = LoaderSize.small,
    this.loaderColor,
    this.style,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final content = isLoading
        ? Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: 16,
                height: 16,
                child: CustomLoader(
                  type: LoaderType.circular,
                  size: loaderSize,
                  color: loaderColor ?? Colors.white,
                ),
              ),
              const SizedBox(width: 8),
              Text('Loading...'),
            ],
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    if (icon != null && !isLoading) {
      return ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: icon!,
        label: Text(text),
        style: style,
      );
    }

    return ElevatedButton(
      onPressed: isLoading ? null : onPressed,
      style: style,
      child: content,
    );
  }
}