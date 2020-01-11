import 'package:flutter/material.dart';

class MyRec extends StatelessWidget {
  final double width;
  const MyRec({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(width, 0),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const pi = 3.14;
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(size.width * 0.80, 0);
    // path.quadraticBezierTo(
    //     size.width * .875, size.height * 0.085, size.width * 0.95, 0);
    path.cubicTo(
        size.width * 0.825, 30, size.width * 0.925, 30, size.width * 0.95, 0);
    // path.arcTo(Rect.fromLTRB(size.width * 0.80, -25, size.width * 0.95, 25),
    //     0 * (pi / 180.0), 180 * (pi / 180.0), false);
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
