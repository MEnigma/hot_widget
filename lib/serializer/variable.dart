/*
* @auther : Mark
* @date : 2019-12-24
* @ide : VSCode
*/

import 'package:flutter/material.dart';
import 'json_serializer.dart';

/// 变量生成器
class VariableSerializer extends BaseSerializer {
  VariableSerializer({@required this.name, this.value});
  VariableSerializer.fromJson(code) : super.fromJson(code) {
    decodeJson(code);
  }

  /// 变量名称
  String name;

  /// 数据,默认字符串类型
  dynamic value;

  VariableSerializer copy() {
    return VariableSerializer(name: name, value: value);
  }

  /// 加法操作,返回新数据
  dynamic add(VariableSerializer other) {
    assert(value.runtimeType == other.value.runtimeType, "变量类型不同,无法进行操作 add");
    switch (value.runtimeType) {
      case double:
      case int:
      case String:
        return value + other.value;
      case List:
        return List.from(value as List)..addAll(other.value);
      case Map:
        return Map.from(value as Map)..addAll(other.value);
      default:
    }
  }

  /// 减法操作,返回新数据
  dynamic sub(VariableSerializer other) {
    assert(value.runtimeType == other.value.runtimeType, "变量类型不同,无法进行操作 add");
    switch (value.runtimeType) {
      case String:
      case int:
      case double:
        return value - other.value;
      case List:
        return List.from(value as List)
          ..removeWhere((var val) => (other.value as List).contains(val));
      case Map:
        return Map.from(value as Map)
          ..removeWhere((key, val) => (other.value as Map).containsKey(key));
      default:
    }
  }

  /// * 动态类型无法进行操作
  VariableSerializer operator +(VariableSerializer other) {
    assert(value.runtimeType == other.value.runtimeType, "变量类型不同,无法进行操作(+)");
    VariableSerializer newVal = copy();
    switch (newVal.runtimeType) {
      case double:
      case int:
      case String:
        newVal.value += other.value;
        break;
      default:
    }
    return newVal;
  }

  @override
  void decodeJson(Map code) {
    // TODO: implement decodeJson
    super.decodeJson(code);
    if(code==null)return;
    name = code['name'] ?? "";
    value = code['value'] ?? "";
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addEntries([
        MapEntry("name", name ?? ""),
        MapEntry("value", value ?? ""),
      ]);
  }
}
