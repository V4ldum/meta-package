import 'package:flutter/material.dart';
import 'package:meta_package/src/internal/internal_app_component_size.dart';
import 'package:meta_package/src/internal/internal_app_padding.dart';
import 'package:meta_package/src/widget/shimmer.dart';

/// Building block used to created the shimmering UI.
/// This block doesn't provide the shimmering effect, it is only used to outline the layout
/// of the page. To add the shimmering effect, wrap the whole page with the [Shimmer] widget
class ShimmerBlock extends StatelessWidget {
  /// Create a block for a shimmer loading effect.
  /// This constructor creates a square and is mostly used for big UI elements likes images
  /// though it can be shaped to be anything.
  /// For texts, see [ShimmerBlock.text].
  const ShimmerBlock({
    super.key,
    this.width = InternalAppComponentSize.l,
    this.height = InternalAppComponentSize.l,
    this.padding = EdgeInsets.zero,
    this.borderRadius = const BorderRadius.all(Radius.circular(InternalAppPadding.s)),
  });

  /// Create a block for a shimmer loading effect
  /// This constructor creates a rectangle and is mostly used for text elements though it
  /// can be shaped to be anything.
  const ShimmerBlock.text({
    super.key,
    this.width = double.infinity,
    this.height = InternalAppPadding.l,
    this.padding = const EdgeInsets.symmetric(vertical: InternalAppPadding.xs),
    this.borderRadius = const BorderRadius.all(Radius.circular(InternalAppPadding.s)),
  });

  /// The width of the block.
  final double width;

  /// The height of the block.
  final double height;

  /// The padding around the block.
  final EdgeInsetsGeometry padding;

  /// The border radius of the block.
  final BorderRadiusGeometry borderRadius;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: borderRadius,
        ),
        width: width,
        height: height,
      ),
    );
  }
}
