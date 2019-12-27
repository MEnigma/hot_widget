/*
* @auther : Mark
* @date : 2019-12-24
* @ide : VSCode
*/

import 'package:flutter/material.dart';
import '../hot_widget.dart';

class BorderGeneractor extends BorderSide {
  BorderGeneractor(BorderSerializer borderSerializer)
      : super(width: borderSerializer.width, color: borderSerializer.color);
}

class TextStyleGeneractor extends TextStyle {
  TextStyleGeneractor(TextStyleSerializer generactor)
      : super(
            fontSize: generactor == null ? null : generactor.size,
            color: generactor == null ? null : generactor.color);
}
