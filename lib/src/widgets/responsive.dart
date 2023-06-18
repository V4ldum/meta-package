import 'package:flutter/material.dart';

/// Renders a different Widget based on the current width of the screen
class Responsive extends StatelessWidget {
  /// Constructor for [Responsive]
  const Responsive({
    required this.mobile,
    this.tablet,
    this.desktop,
    super.key,
  });

  static const int _tabletBreakpoint = 740;
  static const int _desktopBreakpoint = 1200;

  /// The Widget to render if using a desktop screen
  /// If null, [tablet] will be used instead
  final Widget? desktop;

  /// The Widget to render if using a tablet screen
  /// If null, [mobile] will be used instead
  final Widget? tablet;

  /// The Widget to render if using a mobile screen
  final Widget mobile;

  /// Compare the screen's current width with a breakpoint to verify whether the device is a mobile
  static bool isMobile(BuildContext context) => MediaQuery.of(context).size.width < _tabletBreakpoint;

  /// Compare the screen's current width with a breakpoint to verify whether the device is a tablet
  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= _tabletBreakpoint && !isDesktop(context);

  /// Compare the screen's current width with a breakpoint to verify whether the device is a desktop
  static bool isDesktop(BuildContext context) => MediaQuery.of(context).size.width >= _desktopBreakpoint;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    // Desktop UI
    if (width >= _desktopBreakpoint && desktop != null) {
      return desktop!;
    }

    // Tablet UI
    if (width >= _tabletBreakpoint && tablet != null) {
      return tablet!;
    }

    // Mobile UI
    return mobile;
  }
}
