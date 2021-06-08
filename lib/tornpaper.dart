library tornpaper;

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tornpaper/clippath.dart';
import 'package:tornpaper/tornpainterbackground.dart';
import 'package:tornpaper/tornpainterborder.dart';

enum TornedSide { left, top, right, bottom }

class TornPaper extends StatefulWidget {
  final Widget child;
  final List<TornedSide> tornedSides;
  final int seed;
  final int stepWidth;
  final Color tornColor;
  final double tornWidth;
  final double tornDeepness;
  final Color backgroundColor;
  final bool hasNoise;
  final Color noiseColor;
  final bool hasBorder;
  final bool hasShadow;
  final Offset shadowOffset;
  final Color shadowColor;

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
      : super(key: key) {
    assert(stepWidth > 0);
    assert(tornWidth > 0);
  }

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
    var maxWidth = constraints.biggest.width;
    var maxHeight = constraints.maxHeight;
    if (maxWidth == _lastWidth && maxHeight == _lastHeight) {
      return _lastPath;
    }

    //Reset Randoms to have stabilized Lines
    _randomRight = Random(widget.seed);
    _randomLeft = Random(widget.seed * 2);
    _randomTop = Random(widget.seed * 3);
    _randomBottom = Random(widget.seed * 4);

    List<double> doublesRight = List.generate(maxHeight.toInt(),
        (index) => (_randomRight.nextDouble() * widget.tornDeepness));
    doublesRight.first = widget.tornDeepness;
    doublesRight.last = 0.0;
    List<double> doublesLeft = List.generate(maxHeight.toInt(),
        (index) => (_randomLeft.nextDouble() * widget.tornDeepness));
    doublesLeft.first = 0.0;
    doublesLeft.last = 0.0;
    List<double> doublesTop = List.generate(maxWidth.toInt(),
        (index) => (_randomTop.nextDouble() * widget.tornDeepness));
    doublesTop.first = 0.0;
    doublesTop.last = widget.tornDeepness;
    List<double> doublesBottom = List.generate(maxWidth.toInt(),
        (index) => (_randomBottom.nextDouble() * widget.tornDeepness));
    doublesBottom.first = widget.tornDeepness;
    doublesBottom.last = widget.tornDeepness;

    Path pathBackground = Path();
    pathBackground.moveTo(0, 0);
    pathBackground.lineTo(maxWidth, 0);
    pathBackground.lineTo(maxWidth, maxHeight);
    pathBackground.lineTo(0, maxHeight);
    pathBackground.close();

    Path pathWhite = Path();
    pathWhite.moveTo(0, 0);

    // top
    if (widget.tornedSides.contains(TornedSide.top)) {
      for (var i = 0; i < doublesTop.length; i += widget.stepWidth) {
        pathWhite.lineTo((i).toDouble(), doublesTop[i]);
      }
    }
    pathWhite.lineTo(maxWidth, 0);

    // right
    if (widget.tornedSides.contains(TornedSide.right)) {
      for (var i = 0; i < doublesRight.length; i += widget.stepWidth) {
        pathWhite.lineTo(
            maxWidth - widget.tornDeepness + doublesRight[i], (i).toDouble());
      }
    }
    pathWhite.lineTo(maxWidth, maxHeight);

    // bottom
    if (widget.tornedSides.contains(TornedSide.bottom)) {
      for (var i = 0; i < doublesBottom.length; i += widget.stepWidth) {
        pathWhite.lineTo(maxWidth - (i).toDouble(),
            maxHeight + doublesBottom[i] - widget.tornDeepness);
      }
    }
    pathWhite.lineTo(0, maxHeight);

    //left
    if (widget.tornedSides.contains(TornedSide.left)) {
      for (var i = 0; i < doublesLeft.length; i += widget.stepWidth) {
        pathWhite.lineTo(doublesLeft[i], maxHeight - (i).toDouble());
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
