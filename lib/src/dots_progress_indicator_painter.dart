import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// {@template dots_progress_indicator_painter}
/// A custom painter to paint a number of pulsing dots.
/// {@endtemplate}
class DotsProgressIndicatorPainter extends CustomPainter {
  /// {@macro dots_progress_indicator_painter}
  DotsProgressIndicatorPainter({
    required Animation<double> animation,
    required Color backgroundColor,
    required Color color,
    required Curve curve,
    required double dotDiameter,
    required int numberOfDots,
    required double spaceBetween,
    required TextDirection textDirection,
  })  : _textDirection = textDirection,
        _spaceBetween = spaceBetween,
        _numberOfDots = numberOfDots,
        _dotDiameter = dotDiameter,
        _curve = curve,
        _backgroundPaint = Paint()
          ..color = backgroundColor
          ..style = PaintingStyle.fill,
        _dotPaint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        _totalWidth =
            numberOfDots * dotDiameter + (numberOfDots - 1) * spaceBetween,
        super(repaint: animation) {
    _initAnimations(animation);
  }

  /// The animation curve to use when animating a dot size.
  final Curve _curve;

  /// The maximum diameter of each dot.
  final double _dotDiameter;

  /// The number of dots to display.
  final int _numberOfDots;

  /// The space between dots so that the distance between the center of two dots
  /// equals [_dotDiameter] + [_spaceBetween].
  final double _spaceBetween;

  /// The directionality of the text.
  final TextDirection _textDirection;

  /// The animations for each dot
  final _animations = <Animation<double>>[];

  /// The paint applied to the background of the painter.
  final Paint _backgroundPaint;

  /// The paint with which each dot is painted.
  final Paint _dotPaint;

  /// The width of all dots
  final double _totalWidth;

  void _initAnimations(
    Animation<double> animation,
  ) {
    final tweenSequence = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: 0,
          end: _dotDiameter,
        ),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(
          begin: _dotDiameter,
          end: 0,
        ),
        weight: 50,
      ),
    ]);

    const relativeDuration = 0.7;
    final timeIncrement = (1 - relativeDuration) / _numberOfDots;

    for (var i = 0; i < _numberOfDots; i++) {
      final start = i * timeIncrement;
      _animations.add(
        tweenSequence.animate(
          CurvedAnimation(
            parent: animation,
            curve: Interval(
              start,
              start + relativeDuration,
              curve: _curve,
            ),
          ),
        ),
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width < _totalWidth || size.height < _dotDiameter) {
      return;
    }

    if (_backgroundPaint.color.alpha != 0) {
      canvas.drawRect(Offset.zero & size, _backgroundPaint);
    }

    var dotSizes =
        _animations.map((animation) => animation.value).toList(growable: false);

    if (TextDirection.ltr != _textDirection) {
      dotSizes = dotSizes.reversed.toList();
    }

    var x = ((size.width - _totalWidth) / 2) + (_dotDiameter / 2);
    final y = size.height / 2;
    for (final dotSize in dotSizes) {
      if (dotSize > 0) {
        canvas.drawCircle(Offset(x, y), dotSize / 2, _dotPaint);
      }
      x += _dotDiameter + _spaceBetween;
    }
  }

  @override
  bool shouldRepaint(covariant DotsProgressIndicatorPainter oldDelegate) {
    return oldDelegate._backgroundPaint.color != _backgroundPaint.color ||
        oldDelegate._dotPaint.color != _dotPaint.color ||
        oldDelegate._curve != _curve ||
        oldDelegate._dotDiameter != _dotDiameter ||
        oldDelegate._numberOfDots != _numberOfDots ||
        oldDelegate._spaceBetween != _spaceBetween ||
        oldDelegate._textDirection != _textDirection;
  }
}
