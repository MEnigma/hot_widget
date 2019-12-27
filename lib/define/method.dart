/*
* @auther : Mark
* @date : 2019-12-25
* @ide : VSCode
*/

import '../serializer/json_serializer.dart';

import '../hot_widget.dart';
import 'package:flutter/material.dart';

/// 跳转到云端控件
void pushTo({List runtimeparams = const []}) {
  print("enter push : $runtimeparams");
  if (runtimeparams == null || runtimeparams.length == 0) return;
  Map data = runtimeparams[0];
  var serializer = MWidgetSerializer.loadJsonConfig(data);
  Navigator.of(HotWidgetManager.shareManager.interfaceContext).push(
      MaterialPageRoute(
          builder: (ctx) => MWidgetGeneractor.generacte(serializer)));
}

/// 跳回
void pop({List runtimeparams = const []}) {
  Navigator.of(HotWidgetManager.shareManager.interfaceContext).pop();
}
