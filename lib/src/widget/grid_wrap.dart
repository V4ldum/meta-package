import 'package:flutter/material.dart';

/// Widget allowing to create a grid of fixed-size elements that wraps based
/// on the space available on the main axis
class GridWrap extends StatelessWidget {
  /// Constructor for [GridWrap]
  const GridWrap({
    required this.itemWidth,
    required this.itemHeight,
    this.direction = Axis.horizontal,
    this.mainAxisAlignment = WrapAlignment.start,
    this.spacing = 0.0,
    this.runSpacing = 0.0,
    this.crossAxisAlignment = WrapCrossAlignment.start,
    this.verticalDirection = VerticalDirection.down,
    this.children = const [],
    super.key,
  });

  /// The list of items to render in the grid
  final List<Widget> children;

  /// The width of one item
  final double itemWidth;

  /// The height of one item
  final double itemHeight;

  /// The cardinal direction of the grid
  final Axis direction;

  /// How the grid should align items along the main axis
  final WrapAlignment mainAxisAlignment;

  /// The space between items along the main axis
  final double spacing;

  /// The space between items along the cross axis
  final double runSpacing;

  /// How the grid should align items along the cross axis
  final WrapCrossAlignment crossAxisAlignment;

  /// Whether the grid should grow down or up
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final rowSize = (constraints.maxWidth / itemWidth).floor();
          final columnSize = (children.length / rowSize).ceil();
          final maxLength = columnSize * rowSize;

          return Wrap(
            direction: direction,
            alignment: mainAxisAlignment,
            spacing: spacing,
            runSpacing: runSpacing,
            crossAxisAlignment: crossAxisAlignment,
            verticalDirection: verticalDirection,
            children: List.generate(maxLength, (index) {
              return index < children.length ? children[index] : SizedBox(width: itemWidth, height: itemHeight);
            }),
          );
        },
      ),
    );
  }
}
