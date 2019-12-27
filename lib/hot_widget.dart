/*
* @auther : Mark
* @date : 2019-12-25
* @ide : VSCode
*/

export './generactor/style.dart';
export './generactor/widgets.dart';
export './serializer/action.dart';
export './serializer/variable.dart';
export './serializer/widget.dart';
export './serializer/json_serializer.dart';
import './define/method.dart';
import 'package:flutter/material.dart';

class HotWidgetManager {
  static HotWidgetManager _sharemanager = HotWidgetManager();
  static HotWidgetManager get shareManager => _sharemanager;

  /// 入口上下文
  /// 在动态页面入口处的上下文,该属性不会销毁
  BuildContext interfaceContext;

  /// 方法路由
  final Map<dynamic, Function> methodRoute = {"pushTo": pushTo, "pop": pop};

  /// 是否定义了某方法
  bool defineMethod(String method) {
    if (interfaceContext == null) {
      print("${'*' * 30}\n ----- 请设置入口上下文 ----- \n${'*' * 30}");
    }
    return methodRoute.keys.contains(method);
  }
}
