library tornpaper;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tornpaper/clippath.dart';
import 'package:tornpaper/tornpainterbackground.dart';
import 'package:tornpaper/tornpainterborder.dart';

/// Enum with the possible Sides
enum TornedSide {
  /// Flag for a torn side left
  left,
  /// Flag for a torn side top
  top,
  /// Flag for a torn side right
  right,
  /// Flag for a torn side bottom
  bottom }

  /// TornPaper
class TornPaper extends StatefulWidget {
  /// child widget inside this Container
  final Widget child;
  /// List of sides that are torned
  final List<TornedSide> tornedSides;
  /// Randomseed for torn generation
  final int seed;
  /// step width of torn
  final int stepWidth;
  /// Color of torn
  final Color tornColor;
  /// Width of torn as meant as thickness of border
  final double tornWidth;
  /// How deep is your Torn?
  final double tornDeepness;
  /// Color of Background
  final Color backgroundColor;
  /// Has Noise or not
  final bool hasNoise;
  /// Color of Noise
  final Color noiseColor;
  /// Has Border or not
  final bool hasBorder;
  /// Has shadow or not
  final bool hasShadow;
  /// Offset of the shadow in relation to the container
  final Offset shadowOffset;
  /// Color of the shadow
  final Color shadowColor;

  /// Constructor of TornPaper
  TornPaper(
      {this.child = const SizedBox.shrink(),
      this.tornedSides = const [],
      this.seed = 369,
      this.stepWidth = 8,
      this.tornColor = Colors.black,
      this.tornWidth = 1.0,
      this.tornDeepness = 5.0,
      this.backgroundColor = Colors.white,
      this.hasNoise = false,
      this.noiseColor = Colors.black,
      this.hasBorder = true,
      this.shadowOffset = const Offset(8.0, 8.0),
      this.shadowColor = Colors.black,
      this.hasShadow = true,
      Key? key})
      : assert(stepWidth > 0), assert(tornWidth > 0), super(key: key);

  @override
  _TornPaperState createState() => _TornPaperState();
}

class _TornPaperState extends State<TornPaper> {
  // One Random for each side
  // to let the path of one side not depend on other sides
  Random _randomRight = Random(0);
  Random _randomLeft = Random(0);
  Random _randomTop = Random(0);
  Random _randomBottom = Random(0);

  //Caching
  double _lastWidth = 0.0;
  double _lastHeight = 0.0;
  Path _lastPath = Path();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => CustomPaint(
        foregroundPainter: TornPainterBorder(getPath(constraints),
            widget.hasBorder, widget.tornColor, widget.tornWidth),
        painter: TornPainterBackground(
            getPath(constraints),
            constraints.biggest.width,
            constraints.biggest.height,
            widget.backgroundColor,
            widget.hasNoise,
            widget.noiseColor,
            widget.hasShadow,
            widget.shadowOffset,
            widget.shadowColor),
        child: ClipPath(
            clipper: ClipPathClass(getPath(constraints)), child: widget.child),
      ),
    );
  }

  Path getPath(BoxConstraints constraints) {
    final maxWidth = constraints.biggest.width;
    final maxHeight = constraints.maxHeight;
    if (maxWidth == _lastWidth && maxHeight == _lastHeight) {
      return _lastPath;
    }

    //Reset Randoms to have stabilized Lines
    _randomRight = Random(widget.seed);
    _randomLeft = Random(widget.seed * 2);
    _randomTop = Random(widget.seed * 3);
    _randomBottom = Random(widget.seed * 4);

    final List<double> doublesRight = List.generate(maxHeight.toInt(),
        (index) => _randomRight.nextDouble() * widget.tornDeepness);
    doublesRight.first = widget.tornDeepness;
    doublesRight.last = 0.0;
    final List<double> doublesLeft = List.generate(maxHeight.toInt(),
        (index) => _randomLeft.nextDouble() * widget.tornDeepness);
    doublesLeft.first = 0.0;
    doublesLeft.last = 0.0;
    final List<double> doublesTop = List.generate(maxWidth.toInt(),
        (index) => _randomTop.nextDouble() * widget.tornDeepness);
    doublesTop.first = 0.0;
    doublesTop.last = widget.tornDeepness;
    final List<double> doublesBottom = List.generate(maxWidth.toInt(),
        (index) => _randomBottom.nextDouble() * widget.tornDeepness);
    doublesBottom.first = widget.tornDeepness;
    doublesBottom.last = widget.tornDeepness;

    final Path pathWhite = Path();
    pathWhite.moveTo(0, 0);

    // top
    if (widget.tornedSides.contains(TornedSide.top)) {
      for (var i = 0; i < doublesTop.length; i += widget.stepWidth) {
        pathWhite.lineTo(i.toDouble(), doublesTop[i]);
      }
    }
    pathWhite.lineTo(maxWidth, 0);

    // right
    if (widget.tornedSides.contains(TornedSide.right)) {
      for (var i = 0; i < doublesRight.length; i += widget.stepWidth) {
        pathWhite.lineTo(
            maxWidth - widget.tornDeepness + doublesRight[i], i.toDouble());
      }
    }
    pathWhite.lineTo(maxWidth, maxHeight);

    // bottom
    if (widget.tornedSides.contains(TornedSide.bottom)) {
      for (var i = 0; i < doublesBottom.length; i += widget.stepWidth) {
        pathWhite.lineTo(maxWidth - i.toDouble(),
            maxHeight + doublesBottom[i] - widget.tornDeepness);
      }
    }
    pathWhite.lineTo(0, maxHeight);

    //left
    if (widget.tornedSides.contains(TornedSide.left)) {
      for (var i = 0; i < doublesLeft.length; i += widget.stepWidth) {
        pathWhite.lineTo(doublesLeft[i], maxHeight - i.toDouble());
      }
    }
    pathWhite.lineTo(0, 0);
    pathWhite.close();

    _lastWidth = maxWidth;
    _lastHeight = maxHeight;
    _lastPath = pathWhite;
    return _lastPath;
  }
}
