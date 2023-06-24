import 'package:flutter/material.dart';

@immutable
class Mask
{
  final Image baseImage;
  final List<Image> masks;
  final List<String> labels;
  const Mask({required this.baseImage, required this.masks, required this.labels});
}