import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ClipPathClass extends CustomClipper<Path> {
  late final Path path;

  ClipPathClass(this.path);

  @override
  Path getClip(Size size) {
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) =>
      (oldClipper as ClipPathClass).path != path;
}
