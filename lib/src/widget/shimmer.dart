import 'package:flutter/material.dart';
import 'package:meta_package/src/widget/shimmer_block.dart';

/// Adds the shimmering effect to the UI.
/// This widget needs to wrap the whole page using [ShimmerBlock]s.
class Shimmer extends StatefulWidget {
  /// Constructor for the [Shimmer] widget.
  const Shimmer({
    required this.child,
    this.shimmerGradient,
    super.key,
  });

  /// The widget to add the shimmer effect to.
  final Widget child;

  /// The gradient of colors to use. It can be a custom [LinearGradient] or
  /// one of the provided [LightThemeLinearGradient] or [DarkThemeLinearGradient].
  /// If kept null, it will use [LightThemeLinearGradient] when the app uses
  /// [Brightness.light] and [DarkThemeLinearGradient] when the app used
  /// [Brightness.dark]
  final LinearGradient? shimmerGradient;

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController _shimmerAnimationController;

  void _onShimmerChange() {
    setState(() {
      // update the shimmer painting.
    });
  }

  @override
  void initState() {
    super.initState();

    _shimmerAnimationController = AnimationController.unbounded(vsync: this)
      ..repeat(
        min: -0.5,
        max: 1.5,
        period: const Duration(seconds: 2),
      );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _shimmerAnimationController.addListener(_onShimmerChange);
  }

  @override
  void dispose() {
    _shimmerAnimationController
      ..removeListener(_onShimmerChange)
      ..dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final shimmerTransform = _SlidingGradientTransform(slidePercent: _shimmerAnimationController.value);
    final shimmerGradient = widget.shimmerGradient != null
        ? widget.shimmerGradient!
        : Theme.of(context).brightness == Brightness.light
            ? LightThemeLinearGradient(transform: shimmerTransform)
            : DarkThemeLinearGradient(transform: shimmerTransform);

    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: shimmerGradient.createShader,
      child: widget.child,
    );
  }
}

//transform: _SlidingGradientTransform(slidePercent: _shimmerController.value),

/// Shimmer Animation

class _SlidingGradientTransform extends GradientTransform {
  const _SlidingGradientTransform({
    required this.slidePercent,
  });

  final double slidePercent;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(bounds.width * slidePercent, 0, 0);
  }
}

/// Custom Shimmer Themes

/// A dark theme Shimmer effect
class DarkThemeLinearGradient extends _CustomTheme {
  /// Constructor for this theme
  const DarkThemeLinearGradient({
    super.transform,
  }) : super(
          colors: const [
            Color(0xFF2a2a2a),
            Color(0xFF3a3a3a),
            Color(0xFF2a2a2a),
          ],
        );
}

/// A light theme Shimmer effect
class LightThemeLinearGradient extends _CustomTheme {
  /// Constructor for this theme
  const LightThemeLinearGradient({
    super.transform,
  }) : super(
          colors: const [
            Color(0xFFEBEBF4),
            Color(0xFFF4F4F4),
            Color(0xFFEBEBF4),
          ],
        );
}

class _CustomTheme extends LinearGradient {
  const _CustomTheme({
    required super.colors,
    super.transform,
  }) : super(
          stops: const [
            0.1,
            0.3,
            0.4,
          ],
          begin: const Alignment(-1, -0.3),
          end: const Alignment(1, 0.3),
        );
}
