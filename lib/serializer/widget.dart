/*
* @auther : Mark
* @date : 2019-12-24
* @ide : VSCode
*/

import 'package:flutter/material.dart';
import '../serializer/style.dart';
import 'json_serializer.dart';
import 'action.dart';

/// 控件类型
/// ***** 增加时只能在尾部添加,不然会影响线上json顺序 *****
enum WidgetType {
  container,
  text,
  textfield,
  flex,
  row,
  colum,
  hero,
  scafford,
  button,
  stateless,
  stateful,
  fulturebuilder,
  stack,
  img,
}

/// 控件配置器
class WidgetSerializer extends BaseSerializer {
  WidgetSerializer(
      {@required this.widgetType,
      this.width,
      this.height,
      this.tag,
      this.padding = EdgeInsets.zero,
      this.margin = EdgeInsets.zero,
      this.cornerRadiu = 0,
      this.color = Colors.white,
      this.text = "",
      this.imgUrl = "",
      this.textStyle,
      this.child,
      this.alignment = Alignment.topLeft});

  WidgetSerializer.fromJson(Map json) : super.fromJson(json) {
    decodeJson(json);
  }

  /// 控件类型 -- container/text/.../
  WidgetType widgetType;
  // 宽
  double width;

  // 高
  double height;

  // hero - tag
  String tag;

  // 边界
  EdgeInsets padding;

  // 外边距
  EdgeInsets margin;

  // 背景色
  Color color;

  // 边角
  double cornerRadiu;

  // 显示的文本
  String text;

  // 图片地址
  String imgUrl;

  // 对其方式
  Alignment alignment;

  // 字样
  TextStyleSerializer textStyle;

  // 子控件
  WidgetSerializer child;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    widgetType = WidgetType.values[(coder['widgetType'] ??
        WidgetType.values.indexOf(WidgetType.container))];
    width = coder['width'];
    height = coder['height'];
    tag = coder['tag'];
    padding = decodeEdge(coder['padding']);
    margin = decodeEdge(coder['margin']);
    color = decodeColor(coder['color']);
    cornerRadiu = coder['cornerRadiu'] ?? 0;
    text = coder['text'] ?? "";
    imgUrl = coder['imgUrl'] ?? "";
    alignment = decodeAlignment(coder['alignment']);
    textStyle = TextStyleSerializer.fromJson(coder['textStyle'] ?? {});
    try {
      Map childConfig = coder['child'];
      if (childConfig != null)
        child = MWidgetSerializer.loadJsonConfig(coder['child'] ?? {});
    } catch (e) {}
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "widgetType":
            WidgetType.values.indexOf(widgetType ?? WidgetType.container),
        "width": width,
        "height": height,
        "tag": tag,
        "padding": encodeEdge(padding),
        "margin": encodeEdge(margin),
        "color": encodeColor(color),
        "cornerRadiu": cornerRadiu ?? 0,
        "text": text ?? "",
        "imgUrl": imgUrl ?? "",
        "alignment": encodeAlignment(alignment),
        "textStyle": textStyle?.encodeJson(),
        "child": child?.encodeJson(),
      });
  }
}

/// 文本
class TextSerializer extends WidgetSerializer {
  TextSerializer({
    @required String text,
    TextStyleSerializer style,
  }) : super(widgetType: WidgetType.text, text: text, textStyle: style);

  TextSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    if (coder['style'] == null) {
      super.textStyle = TextStyleSerializer.normalText();
    }
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()..addAll({"text": text});
  }
}

/// 按钮
class ButtonSerializer extends WidgetSerializer {
  ButtonSerializer({@required WidgetSerializer child, @required this.ontap})
      : super(widgetType: WidgetType.button, child: child);

  ButtonSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  /// 点击事件
  MethodSerializer ontap;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    ontap = MethodSerializer.fromJson(coder['ontap'] ?? {});
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()..addAll({"ontap": ontap.encodeJson()});
  }
}

/// 输入框
class TextFieldSerializer extends WidgetSerializer {
  TextFieldSerializer({
    this.maxlines = 0,
    this.maxLength = 0,
    this.editingText = "",
    this.autoFocused = false,
    this.obscureText = false,
  }) : super(widgetType: WidgetType.textfield);

  TextFieldSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  /// 最大行数
  int maxlines;

  /// 最大长度
  int maxLength;

  /// 编辑中的文字
  String editingText;

  /// 自动获取焦点
  bool autoFocused;

  /// 密文输入
  bool obscureText;
  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    maxlines = coder['maxlines'] ?? 0;
    maxLength = coder['maxLength'] ?? 0;
    editingText = coder['editingText'] ?? "";
    autoFocused = coder['autoFocused'] ?? false;
    obscureText = coder['obscureText'] ?? false;
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "maxlines": maxlines ?? 0,
        "maxLength": maxLength ?? 0,
        "editingText": editingText ?? "",
        "autoFocused": autoFocused ?? false,
        "obscureText": obscureText ?? false,
      });
  }
}

/// 图片
class ImageSerializer extends WidgetSerializer {
  ImageSerializer({this.assetImg, String url})
      : super(imgUrl: url, widgetType: WidgetType.img);

  ImageSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }
  // 本地图片
  String assetImg;

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "assetImg": assetImg ,
      });
  }

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    assetImg = coder['assetImg'];
  }
}

/// flexble
class MultiChildrenSerializer extends WidgetSerializer {
  MultiChildrenSerializer(
      {@required this.children,
      @required WidgetType widgetType,
      this.direction = Axis.vertical,
      this.mainAxisAlignment = MainAxisAlignment.start,
      this.crossAxisAlignment = CrossAxisAlignment.start,
      this.mainAxisSize = MainAxisSize.max})
      : super(widgetType: widgetType);

  MultiChildrenSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  // 子内容
  List children;

  // 排版方向
  Axis direction;

  // 主方向对其方式
  MainAxisAlignment mainAxisAlignment;

  // 主方向上长度规则
  MainAxisSize mainAxisSize;

  // 垂向对其方式
  CrossAxisAlignment crossAxisAlignment;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    children = (coder['children'] ?? [])
        .map((var val) => MWidgetSerializer.loadJsonConfig(val))
        .toList();
    direction =
        Axis.values[coder['direction'] ?? Axis.values.indexOf(Axis.vertical)];
    mainAxisAlignment = MainAxisAlignment.values[coder['mainAxisAlignment'] ??
        MainAxisAlignment.values.indexOf(MainAxisAlignment.start)];
    crossAxisAlignment = CrossAxisAlignment.values[
        coder['crossAxisAlignment'] ??
            CrossAxisAlignment.values.indexOf(CrossAxisAlignment.start)];
    mainAxisSize = MainAxisSize.values[
        coder['mainAxisSize'] ?? MainAxisSize.values.indexOf(MainAxisSize.max)];
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "children": (children ?? [])
            .map((var serializer) => serializer.encodeJson())
            .toList(),
        "direction": Axis.values.indexOf(direction ?? Axis.vertical),
        "mainAxisAlignment": MainAxisAlignment.values
            .indexOf(mainAxisAlignment ?? MainAxisAlignment.start),
        "mainAxisSize":
            MainAxisSize.values.indexOf(mainAxisSize ?? MainAxisSize.max),
        "crossAxisAlignment": CrossAxisAlignment.values
            .indexOf(crossAxisAlignment ?? CrossAxisAlignment.start),
      });
  }
}

/// 脚手架
class ScaffordSerializer extends WidgetSerializer {
  ScaffordSerializer(
      {@required this.body, this.title, this.leading, this.actions})
      : super(widgetType: WidgetType.scafford);

  ScaffordSerializer.fromJson(Map coder) : super.fromJson(coder) {
    decodeJson(coder);
  }

  /// body
  WidgetSerializer body;

  /// 标题
  WidgetSerializer title;

  /// 返回按钮
  ButtonSerializer leading;

  /// 右上角
  List<ButtonSerializer> actions;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    body = coder['body'] != null
        ? MWidgetSerializer.loadJsonConfig(coder['body'])
        : null;
    title = coder['title'] != null
        ? MWidgetSerializer.loadJsonConfig(coder['title'])
        : null;
    leading = coder['leading'] != null
        ? MWidgetSerializer.loadJsonConfig(coder['leading'])
        : null;
    actions = coder['actions'] != null
        ? (coder['actions'] ?? [])
            .map((var val) => MWidgetSerializer.loadJsonConfig(val))
            .toList()
        : null;
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "body": body != null ? body.encodeJson() : null,
        "title": title != null ? title.encodeJson() : null,
        "leading": leading != null ? leading.encodeJson() : null,
        "actions": actions != null
            ? (actions ?? [])
                .map((ButtonSerializer serializer) => serializer.encodeJson())
                .toList()
            : null,
      });
  }

  Map toJson()=>encodeJson();
}

/// 异步加载控件
class FutureBuilderSerializer extends WidgetSerializer {
  FutureBuilderSerializer(
      {@required this.future,
      @required this.holdchild,
      @required this.loadChild,
      this.errorrChild})
      : super(widgetType: WidgetType.fulturebuilder);

  FutureBuilderSerializer.fromJson(Map code) : super.fromJson(code) {
    decodeJson(code);
  }

  /// 异步方法
  MethodSerializer future;

  /// 等待中显示��视图
  WidgetSerializer holdchild;

  /// 完成后显示的视图
  WidgetSerializer loadChild;

  /// 错误视图
  WidgetSerializer errorrChild;

  @override
  void decodeJson(Map coder) {
    // TODO: implement decodeJson
    super.decodeJson(coder);
    future = MethodSerializer.fromJson(coder['future'] ?? {});
    holdchild = MWidgetSerializer.loadJsonConfig(coder['holdchild'] ?? {});
    loadChild = MWidgetSerializer.loadJsonConfig(coder['loadChild'] ?? {});
    errorrChild = MWidgetSerializer.loadJsonConfig(coder['errorrChild'] ?? {});
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return super.encodeJson()
      ..addAll({
        "future": future.encodeJson(),
        "holdchild": holdchild.encodeJson(),
        "loadChild": loadChild.encodeJson(),
        "errorrChild": errorrChild.encodeJson(),
      });
  }
}

/// stack
class StackSerializer extends WidgetSerializer {
  StackSerializer({@required this.children, this.fit = StackFit.loose})
      : super(widgetType: WidgetType.stack);

  List<WidgetSerializer> children;

  StackFit fit;

  StackSerializer.fromJson(Map code) : super.fromJson(code) {
    decodeJson(code);
  }

  @override
  void decodeJson(Map coder) {
    super.decodeJson(coder);
    children = (coder['children'] ?? [])
        .map((var val) => MWidgetSerializer.loadJsonConfig(val))
        .toList();
    fit = StackFit.values[(coder['fit'] ?? 0)];
  }

  @override
  Map encodeJson() => super.encodeJson()
    ..addAll({
      "fit": StackFit.values.indexOf(fit),
      "children": children.map((var val) => val.encodeJson()).toList()
    });
}

/// border
class BorderSerializer extends BaseSerializer {
  BorderSerializer({this.width = 0, this.color = Colors.white});

  // 宽度
  double width;

  // 颜色
  Color color;

  BorderSerializer.fromJson(Map code) : super.fromJson(code) {
    decodeJson(code);
  }

  @override
  void decodeJson(Map code) {
    // TODO: implement decodeJson
    super.decodeJson(code);
    width = code['width'];
    color = decodeColor(code['color']);
  }

  @override
  Map encodeJson() => super.encodeJson()
    ..addAll({
      "width": width,
      "color": encodeColor(color),
    });
}

/// 文本样式
class TextStyleSerializer extends BaseSerializer {
  TextStyleSerializer(
      {this.color = Colors.black,
      this.size = 17,
      this.family});

  TextStyleSerializer.fromJson(Map code) : super.fromJson(code) {
    decodeJson(code);
  }

  TextStyleSerializer.normalText(
      {this.color = Colors.black,
      this.size = 17
      });

  // 颜色
  Color color;
  // 大小
  double size;
  // 字体
  String family;
  // // 粗细
  // FontWeight weight;

  @override
  void decodeJson(Map code) {
    color = decodeColor(code['color']);
    size = code['size'];
    family = code['family'];
    // weight = code['weight'] ?? FontWeight._(2);
  }

  @override
  Map encodeJson() {
    // TODO: implement encodeJson
    return {
      "color": encodeColor(color),
      "size": size,
      "family": family,
      // "weight": ,
    };
  }
}
