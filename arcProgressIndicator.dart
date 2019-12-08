

import 'package:flutter/material.dart';
import 'dart:math';

class ArcProgressIndicator extends StatefulWidget {
  final double progress;
  final Color valueColor;
  final double thickness;
  final double angle;
  final Widget child;
  ArcProgressIndicator(
      {this.progress = 0.0,
      this.valueColor = Colors.purple,
      this.thickness = 7.0,
      this.angle = pi * 3 / 2, this.child});
  @override
  _ArcProgressIndicator createState() => _ArcProgressIndicator();
}

class _ArcProgressIndicator extends State<ArcProgressIndicator>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> progressAnimation;
  @override
  void initState() {
    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    progressAnimation =
        Tween(begin: 0.0, end: widget.progress).animate(controller)
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(progressAnimation.value);
    return CustomPaint(
        foregroundPainter: CircleIndicatorPainter(progressAnimation.value,
            widget.valueColor, widget.thickness, widget.angle),
        child: widget.child,);
  }
}

class CircleIndicatorPainter extends CustomPainter {
  final double progress;
  final Color valueColor;
  final double thickness;
  final double angle;
  CircleIndicatorPainter(
      this.progress, this.valueColor, this.thickness, this.angle);
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = valueColor.withOpacity(0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;
    canvas.drawArc(new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        pi / 2 + (2 * pi - angle) / 2, angle, false, paint);
    paint.color = valueColor;
    canvas.drawArc(new Rect.fromLTWH(0.0, 0.0, size.width, size.height),
        pi / 2 + (2 * pi - angle) / 2, angle * progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if ((oldDelegate as CircleIndicatorPainter).progress == this.progress)
      return false;
    return true;
  }
}
