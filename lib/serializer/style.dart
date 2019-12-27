/*
* @auther : Mark
* @date : 2019-12-25
* @ide : VSCode
*/

import 'package:flutter/material.dart';

Color decodeColor(List colors) {
  if (colors == null) return Colors.transparent;
  if (colors.length == 3) {
    return Color.fromRGBO(colors[0], colors[1], colors[2], 1);
  } else if (colors.length == 4) {
    return Color.fromRGBO(colors[0], colors[1], colors[2], colors[3]);
  } else {
    return Colors.transparent;
  }
}

List encodeColor(Color color) {
  return color == null
      ? [0, 0, 0, 0.0]
      : [color.red, color.green, color.blue, color.opacity];
}

EdgeInsets decodeEdge(List edge) {
  if (edge == null) return EdgeInsets.zero;
  if (edge.length == 4) {
    return EdgeInsets.only(
        left: edge[1], top: edge[0], bottom: edge[2], right: edge[3]);
  } else {
    return EdgeInsets.zero;
  }
}

List encodeEdge(EdgeInsets edge) {
  return edge == null
      ? [0.0, 0.0, 0.0, 0.0]
      : [edge.top, edge.left, edge.bottom, edge.right];
}

Alignment decodeAlignment(List alignment) {
  if (alignment == null || alignment.length != 2) {
    return Alignment.center;
  } else {
    return Alignment(alignment[0], alignment[1]);
  }
}

List<double> encodeAlignment(Alignment alignment) {
  if (alignment == null) {
    return [0.0, 0.0];
  } else {
    return [alignment.x, alignment.y];
  }
}
