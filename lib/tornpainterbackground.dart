import 'dart:ui';

import 'package:fast_noise/fast_noise.dart';
import 'package:flutter/material.dart';

/// CustomPaint for the Background
class TornPainterBackground extends CustomPainter {
  
  /// Path for the outline
  final Path path;
  /// width of the container to calculate the noise
  final double width;
  /// height of the container to calculate the noise
  final double height;
  /// Paint for the Background fill color
  late final Paint paintBackground;
  /// Has Noise or not
  final bool hasNoise;
  /// Color of the noise
  final Color noiseColor;
  /// Has Shadow or not
  final bool hasShadow;
  /// Color of the shadow
  final Color shadowColor;
  /// Shifted Path for Shadow, Calculated by given shadowOffset
  late final Path shiftedPath;
  /// Map with a List of Point for diffrent Colors, used to draw the noise
  late final Map<Color, List<Offset>> noisePoints = {};

  /// Constuctor of the TornPainterBackground
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
    paintBackground = Paint()
      ..color = backgroundColor
      ..style = PaintingStyle.fill;

    if (hasNoise) {
      final List<List<double>> noise = noise2(width.toInt(), height.toInt(),
          noiseType: NoiseType.Perlin,
          octaves: 5,
          frequency: 0.75,
          cellularDistanceFunction: CellularDistanceFunction.Euclidean,
          cellularReturnType: CellularReturnType.CellValue);

      for (var x = 0; x < width; x++) {
        for (var y = 0; y < height; y++) {
          // var c = (0x80 + 0x80 * noise[x][y]).floor(); // grayscale
          final offset = Offset(x.toDouble(), y.toDouble());
          if (!path.contains(offset)) {
            continue;
          }
          final color = Color.fromRGBO(
              noiseColor.red, noiseColor.green, noiseColor.blue, noise[x][y]);
          noisePoints.putIfAbsent(color, () => []);
          noisePoints[color]!.add(offset);
        }
      }
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (hasShadow) {
      canvas.drawShadow(shiftedPath, shadowColor, 1.0, true);
    }
    canvas.drawPath(path, paintBackground);
    if (hasNoise) {
      noisePoints.forEach((key, value) {
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
