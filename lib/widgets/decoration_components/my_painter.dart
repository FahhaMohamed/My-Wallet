import 'package:flutter/material.dart';

import '../../constant/colors.dart';


class MyPainter extends CustomPainter {

  final double radius;

  MyPainter(this.radius);

  @override
  void paint (Canvas canvas, Size size) {

    final paint = Paint()
      ..shader = LinearGradient(
        colors: [
          CustomColor.purple[3],
          CustomColor.purple[0],
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(
        Rect.fromCircle(
          center: const Offset(0, 0),
          radius: radius,
        )
      );

    canvas.drawCircle(Offset.zero, radius, paint);
    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}