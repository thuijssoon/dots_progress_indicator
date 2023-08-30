import 'package:dots_progress_indicator/src/dots_progress_indicator_painter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/// {@template dots_progress_indicator}
/// An indeterminate dots progress indicator also know as a spinner.
///
/// A widget that indicates activity by animating the radius of multiple dots
/// positioned along the x axes.
/// {@endtemplate}
class DotsProgressIndicator extends StatefulWidget {
  /// {@macro dots_progress_indicator}
  const DotsProgressIndicator({
    this.backgroundColor = Colors.transparent,
    this.color,
    this.controller,
    this.curve = Curves.linear,
    this.dotDiameter = 10,
    this.duration = const Duration(milliseconds: 1500),
    this.numberOfDots = 3,
    this.semanticsLabel,
    this.spaceBetween = 2,
    super.key,
  });

  /// The background color being filled by the dots indicator.
  final Color backgroundColor;

  /// The progress indicator's color.
  ///
  /// If [ProgressIndicator.color] is null, then the ambient
  /// [ProgressIndicatorThemeData.color] will be used. If that
  /// is null then the current theme's [ColorScheme.primary] will
  /// be used by default.
  final Color? color;

  /// The controller that will control the animation.
  final AnimationController? controller;

  /// The animation curve to use when animating a dot size.
  final Curve curve;

  /// The maximum diameter of each dot.
  final double dotDiameter;

  /// The duration of one animation cycle.
  final Duration duration;

  /// The number of dots to display.
  final int numberOfDots;

  /// The [SemanticsProperties.label] for this progress indicator.
  ///
  /// This value indicates the purpose of the progress indicator, and will be
  /// read out by screen readers to indicate the purpose of this progress
  /// indicator.
  final String? semanticsLabel;

  /// The space between dots so that the distance between the center of two dots
  /// equals [dotDiameter] + [spaceBetween].
  final double spaceBetween;

  Color _getColor(BuildContext context, {Color? defaultColor}) {
    return color ??
        ProgressIndicatorTheme.of(context).color ??
        defaultColor ??
        Theme.of(context).colorScheme.primary;
  }

  @override
  State<DotsProgressIndicator> createState() => _DotsProgressIndicatorState();
}

class _DotsProgressIndicatorState extends State<DotsProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ??
        AnimationController(
          duration: widget.duration,
          vsync: this,
        )
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textDirection = Directionality.of(context);
    return Semantics(
      label: widget.semanticsLabel,
      child: Container(
        constraints: BoxConstraints(
          minHeight: widget.dotDiameter,
          minWidth: (widget.dotDiameter * widget.numberOfDots) +
              (widget.spaceBetween * (widget.numberOfDots - 1)),
        ),
        child: CustomPaint(
          painter: DotsProgressIndicatorPainter(
            animation: _controller.view,
            backgroundColor: widget.backgroundColor,
            color: widget._getColor(context),
            curve: widget.curve,
            dotDiameter: widget.dotDiameter,
            numberOfDots: widget.numberOfDots,
            spaceBetween: widget.spaceBetween,
            textDirection: textDirection,
          ),
        ),
      ),
    );
  }
}
