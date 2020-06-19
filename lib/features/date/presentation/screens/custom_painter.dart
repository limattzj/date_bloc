import 'package:flutter/material.dart';
import 'dart:math';

class MyPainter extends CustomPainter {
  final Color color;

  MyPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final shapeBounds = Rect.fromLTRB(0, 0, size.width, size.height);
    _drawBackground(canvas, shapeBounds);
    _drawArc(canvas, size, shapeBounds);
  }

  void _drawBackground(Canvas canvas, Rect bounds) {
    final paint = Paint()..color = color;

    canvas.drawRect(bounds, paint);
  }

  void _drawArc(Canvas canvas, Size size, Rect bounds) {
    final paint = Paint()..color = Colors.orangeAccent;

    final newBounds = Rect.fromLTWH(
      bounds.topLeft.dx,
      bounds.topLeft.dy,
      bounds.width,
      bounds.height * 2,
    );
    canvas.drawArc(newBounds, pi, pi, false, paint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return oldDelegate.color != color;
  }

  // TODO: implement custom hitTest
  // http://shorturl.at/pGY02
  @override
  bool hitTest(Offset position) {
    return super.hitTest(position);
  }
}
