import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Simple CustomClipPath to clip the Container
class ClipPathClass extends CustomClipper<Path> {

  ///Path of the Clip
  late final Path path;

  /// Constructor. Only path is needed
  ClipPathClass(this.path);

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>
      (oldClipper as ClipPathClass).path != path;
}
