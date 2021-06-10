import 'dart:ui';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

class TornPainterBackground extends CustomPainter {
  final Path path;
  final double width;
  final double height;
  late final Paint paintWhite;
  final bool hasNoise;
  final Color noiseColor;
  final bool hasShadow;
  final Color shadowColor;
  late final Path shiftedPath;
  late final Map<Color, List<Offset>> points = {};

  TornPainterBackground(
    this.path,
    this.width,
    this.height,
    Color backgroundColor,
    this.hasNoise,
    this.noiseColor,
    this.hasShadow,
    Offset shadowOffset,
    this.shadowColor,
  ) {
    shiftedPath = path.shift(shadowOffset);
    paintWhite = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    if (hasNoise) {
      List<List<double>> noise = noise2(width.toInt(), height.toInt(),
          noiseType: NoiseType.Perlin,
          octaves: 5,
          frequency: 0.75,
          cellularDistanceFunction: CellularDistanceFunction.Euclidean,
          cellularReturnType: CellularReturnType.CellValue);

      for (var x = 0; x < width; x++) {
        for (var y = 0; y < height; y++) {
          // var c = (0x80 + 0x80 * noise[x][y]).floor(); // grayscale
          var offset = Offset(x.toDouble(), y.toDouble());
          if (!path.contains(offset)) {
            continue;
          }
          var color = Color.fromRGBO(
              noiseColor.red, noiseColor.green, noiseColor.blue, noise[x][y]);
          points.putIfAbsent(color, () => []);
          points[color]!.add(offset);
        }
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (hasShadow) {
      canvas.drawShadow(shiftedPath, shadowColor, 1.0, true);
    }
    canvas.drawPath(path, paintWhite);
    if (hasNoise) {
      points.forEach((key, value) {
        canvas.drawPoints(
            PointMode.points,
            value,
            Paint()
              ..strokeWidth = 1.0
              ..color = key
              ..style = PaintingStyle.fill);
      });
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) =>
      (oldDelegate as TornPainterBackground).path != path;
}
