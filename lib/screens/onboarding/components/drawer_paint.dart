import 'package:flutter/material.dart';

class DrawerPaint extends CustomPainter {
  final Color curveColor;
  final Paint curvePaint;

  DrawerPaint({this.curveColor = Colors.pink})
      : curvePaint = Paint()
          ..color = curveColor
          ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    
    var path = Path();
    var diameter = size.height / 3;

    path.moveTo(size.width * 0.65, 0);
    path.relativeCubicTo(size.width * 0.65, diameter * 0.4, -size.width * 0.25, diameter / 2, 0, diameter);
    path.relativeCubicTo(size.width * 0.75, diameter * 0.6, -size.width * 0.25, diameter / 2, 0, diameter);
    path.relativeCubicTo(size.width * 0.85, diameter * 0.7, -size.width * 2.25, diameter * 0.7, 0, diameter);
   
   path.lineTo(size.width, size.height);
   path.lineTo(size.width, 0);
   path.close();

   canvas.drawPath(path, curvePaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
