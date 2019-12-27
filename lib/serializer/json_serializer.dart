/*
* @auther : Mark
* @date : 2019-12-26
* @ide : VSCode
*/

import 'dart:convert';

import '../serializer/classes.dart';

import '../hot_widget.dart';
import 'widget.dart';

class MWidgetSerializer {
  static BaseSerializer loadJsonConfig(Map config) {
    int wtype = config['widgetType'];
    if (wtype == null) return BaseSerializer();
    WidgetType type = WidgetType.values[wtype];
    switch (type) {
      case WidgetType.container:
        return WidgetSerializer.fromJson(config);
      case WidgetType.text:
        return TextSerializer.fromJson(config);
      case WidgetType.textfield:
        return TextFieldSerializer.fromJson(config);
      case WidgetType.flex:
      case WidgetType.row:
      case WidgetType.colum:
        return MultiChildrenSerializer.fromJson(config);
      case WidgetType.hero:
        return WidgetSerializer.fromJson(config);
      case WidgetType.scafford:
        return ScaffordSerializer.fromJson(config);
      case WidgetType.button:
        return ButtonSerializer.fromJson(config);
      case WidgetType.stateless:
        return StatelessSerializer.fromJson(config);
      case WidgetType.stateful:
        return StatefulSerializer.fromJson(config);
      case WidgetType.fulturebuilder:
        return FutureBuilderSerializer.fromJson(config);
      case WidgetType.stack:
        return StackSerializer.fromJson(config);
      case WidgetType.img:
        return ImageSerializer.fromJson(config);
      default:
        return BaseSerializer();
    }
  }
}

class BaseSerializer<T> {
  BaseSerializer();
  BaseSerializer.fromJson(Map code) {
    this.decodeJson(code);
  }

  Map encodeJson() => {};
  void decodeJson(Map code) {}

  void logEncode() {
    String code = jsonEncode(encodeJson());
    print(code);
  }
}
