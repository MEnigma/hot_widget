/*
* @auther : Mark
* @date : 2019-12-24
* @ide : VSCode
*/

import 'package:flutter/material.dart';

import '../hot_widget.dart';
import 'json_serializer.dart';

/// 执行
enum ActionExecutionType {
  // 加
  add,
  //减
  sub,
  // 乘
  mul,
  // 除
  divi,
  // 取值
  get,
  // 赋值
  set,
  // 调用
  transfor,
}

/// 返回类型
enum ActionReturnType {
  /// 新内容
  newone,

  /// 返回执行者*数据*
  from,

  /// 返回被执行着*数据*
  to,

  /// 无返回值
  none,
}

/// 方法
class MethodSerializer extends BaseSerializer {
  MethodSerializer({this.name, this.actions, this.context, this.properties});
  MethodSerializer.fromJson(Map code) : super.fromJson(code) {
    decodeJson(code);
  }

  /// 方法名称
  String name;

  /// 内容
  List<ActionSerializer> actions;

  /// 当前所在的
  BuildContext context;

  /// 属性列表
  Map<String, VariableSerializer> properties;

  /// 执行方法
  Future doactions() async {
    for (ActionSerializer action in actions) {
      // 异步方法
      if (HotWidgetManager.shareManager.defineMethod(action.funcName)) {
        //方法已定义
        Function method =
            HotWidgetManager.shareManager.methodRoute[action.funcName];
        if (action.shouldAsync) {
          await method(runtimeparams: action.params);
        } else {
          method(runtimeparams: action.params);
        }
      } else {
        print("${'*' * 30}\n***** 该方法未定义 ***** \n${'*' * 30}");
      }
    }
  }

  /// 执行一条事件
  dynamic transformAction(ActionSerializer action) {
    switch (action.execution) {
      case ActionExecutionType.transfor:
        break;
      default:
    }
  }

  @override
  void decodeJson(Map code) {
    // TODO: implement decodeJson
    super.decodeJson(code);
    name = code['name'] ?? "";
    actions = ActionSerializer.generateSerializers(code['actions'] ?? []);
    properties ??= <String, VariableSerializer>{};
    for (Map config in code['properties'] ?? []) {
      VariableSerializer v = VariableSerializer.fromJson(config);
      properties[v.name] = v;
    }
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addEntries([
        MapEntry("name", name ?? ""),
        MapEntry(
            "actions",
            (actions ?? [])
                .map((ActionSerializer val) => val.encodeJson())
                .toList()),
        MapEntry(
            "properties",
            (properties ?? {})
                .values
                .map((VariableSerializer val) => val.encodeJson())
                .toList()),
      ]);
  }
}

/*
/// 异步方法
class AsyncMethodSerializer extends MethodSerializer {
  AsyncMethodSerializer({
    String name,
    List<ActionSerializer> actions,
    BuildContext context,
    Map<String, VariableSerializer> properties,
  }) : super(
            name: name,
            actions: actions,
            properties: properties,
            context: context);

  @override
  Future doactions() async {}
}
*/
/// 方法生成器
class ActionSerializer extends BaseSerializer {
  ActionSerializer(
      {this.fromTitle,
      this.toTitle,
      this.execution = ActionExecutionType.transfor,
      this.shouldAsync = false,
      this.funcName,
      this.args,
      this.returnType = ActionReturnType.none,
      this.routeName,
      this.params = const []});
  ActionSerializer.fromJson(Map jsondata) : super.fromJson(jsondata) {
    decodeJson(jsondata);
  }

  static List<ActionSerializer> generateSerializers(List group) {
    List<ActionSerializer> serializers = [];
    for (var config in group) {
      serializers.add(ActionSerializer.fromJson(config));
    }
    return serializers;
  }

  /// 路由方法
  dynamic routeName;

  /// 执行者name
  String fromTitle;

  /// 被执行着name
  String toTitle;

  /// 执行的方法名称,操作为执行时有效
  String funcName;

  /// 执行的方法参数,操作为执行时有效
  List args;

  /// 操作
  ActionExecutionType execution;

  /// 返回类型
  ActionReturnType returnType;

  /// 使用异步
  bool shouldAsync;

  /// 参数
  List params;

  @override
  void decodeJson(Map code) {
    // TODO: implement decodeJson
    super.decodeJson(code);
    if (code == null) return;
    routeName = code['routeName'];
    fromTitle = code['fromTitle'];
    toTitle = code['toTitle'];
    funcName = code['funcName'];
    args = code['args'];
    execution = ActionExecutionType.values[code['execution'] ??
        ActionExecutionType.values.indexOf(ActionExecutionType.transfor)];
    returnType = ActionReturnType.values[code['returnType'] ??
        ActionReturnType.values.indexOf(ActionReturnType.none)];
    shouldAsync = code['shouldAsync'];
    params = code['params'];
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addEntries([
        MapEntry("routeName", routeName ?? ""),
        MapEntry("fromTitle", fromTitle ?? ""),
        MapEntry("toTitle", toTitle ?? ""),
        MapEntry("funcName", funcName ?? ""),
        MapEntry("args", args ?? []),
        MapEntry(
            "execution",
            ActionExecutionType.values
                .indexOf(execution ?? ActionExecutionType.transfor)),
        MapEntry(
            "returnType",
            ActionReturnType.values
                .indexOf(returnType ?? ActionReturnType.none)),
        MapEntry("shouldAsync", shouldAsync ?? false),
        MapEntry("params", params ?? []),
      ]);
  }
}
