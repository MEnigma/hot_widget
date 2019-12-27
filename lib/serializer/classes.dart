/*
* @auther : Mark
* @date : 2019-12-25
* @ide : VSCode
*/

import 'package:flutter/material.dart';
import '../serializer/json_serializer.dart';

import '../hot_widget.dart';

/// 类描述
class StatelessSerializer extends WidgetSerializer {
  StatelessSerializer(
      {this.propertys = const <String, VariableSerializer>{},
      @required this.build,
      this.methods = const <String, MethodSerializer>{},
      WidgetType widgetType = WidgetType.stateless})
      : super(widgetType: widgetType);

  StatelessSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  /// 属性列表
  Map<String, VariableSerializer> propertys;

  /// 控件
  WidgetSerializer build;

  /// 方法列表
  Map<String, MethodSerializer> methods;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    build = MWidgetSerializer.loadJsonConfig(coder['build'] ?? {});
    methods = (coder['methods'] ?? []).map((Map val) {
      MethodSerializer method = MethodSerializer.fromJson(val);
      return MapEntry(method.name, method);
    });
    propertys = (coder['propertys'] ?? []).map((Map val) {
      VariableSerializer method = VariableSerializer.fromJson(val);
      return MapEntry(method.name, method);
    });
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "build": build.encodeJson(),
        "methods": (methods ?? {})
            .values
            .map((MethodSerializer serializer) => serializer.encodeJson())
            .toList(),
        "propertys": (propertys ?? {})
            .values
            .map((VariableSerializer serializer) => serializer.encodeJson())
            .toList(),
      });
  }
}

class StatefulSerializer extends StatelessSerializer {
  StatefulSerializer(
      {Map propertys = const <String, VariableSerializer>{},
      @required WidgetSerializer build,
      Map methods = const <String, MethodSerializer>{},
      WidgetType widgetType = WidgetType.stateful,
      this.init})
      : super(
            widgetType: widgetType,
            propertys: propertys,
            methods: methods,
            build: build);
  StatefulSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  /// 初始化中执行的方法
  List<MethodSerializer> init;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    init = (coder['init'] ?? [])
        .map((var val) => MethodSerializer.fromJson(val))
        .toList();
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "init": (init ?? [])
            .map((MethodSerializer serializer) => serializer.encodeJson())
            .toList()
      });
  }
}
