import 'package:flutter/material.dart';

/// CustomPaint for the Border
class TornPainterBorder extends CustomPainter {
  /// Outline Path
  final Path path;
  /// Has Border or not
  final bool hasBorder;
  /// Paint of the Border (color)
  late final Paint paintWhiteStroke;

  /// Constructor of the TornPainterBorder
  TornPainterBorder(
      this.path, this.hasBorder, Color colorOfTorn, double strokeWidth) {
    paintWhiteStroke = Paint()
      ..color = colorOfTorn
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (hasBorder) {
      canvas.drawPath(path, paintWhiteStroke);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      (oldDelegate as TornPainterBorder).path != path;
}

/* Abrisskante in weiß

    // Paint paintPaper = Paint()
    //   ..color = Colors.black12
    //   ..style = PaintingStyle.fill
    //   ..strokeWidth = 1.0;


    // Random r = Random(123);
    // List<double> doubles = List.generate(size.height~/6, (index) => (r.nextDouble()*6)-3);

...


    // Path pathPaper = Path();
    // pathPaper.moveTo(0, 0);
    // pathPaper.lineTo(size.width-10, 0);
    // for (var i = 0; i < doubles.length; i+=stepWidth) {
    //   pathPaper.lineTo(size.width-10+doubles[i], (i*6).toDouble());
    // }
    // pathPaper.lineTo(size.width-10, size.height);
    // pathPaper.lineTo(0, size.height);
    // pathPaper.close();

...

    // canvas.drawPath(pathPaper, paintPaper);


*/
