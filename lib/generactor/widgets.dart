/*
* @auther : Mark
* @date : 2019-12-24
* @ide : VSCode
*/

import 'package:flutter/material.dart';
import '../serializer/classes.dart';

import '../hot_widget.dart';

class MWidgetGeneractor {
  static Widget generacte(WidgetSerializer serializer,
      {BuildContext context,
      Map<String, VariableSerializer> properties,
      Map<String, MethodSerializer> methods,
      MethodSerializer method}) {
    if (serializer == null) return Container();
    switch (serializer.widgetType) {
      case WidgetType.container:
        return MContainer(serializer);
      case WidgetType.text:
        return MText(serializer);
      case WidgetType.textfield:
        return MTextField(serializer);
      case WidgetType.flex:
        return MFlexble(serializer);
      case WidgetType.row:
        return MRow(serializer);
      case WidgetType.colum:
        return MColumn(serializer);
      case WidgetType.button:
        return MButton(serializer);
      case WidgetType.scafford:
        return MScafford(serializer);
      case WidgetType.hero:
        return MHero(serializer);
      case WidgetType.stack:
        return MStack(serializer);
      case WidgetType.fulturebuilder:
        return MFutureWidget(serializer);
      case WidgetType.img:
        return MImage(serializer);
      default:
        return Container();
    }
  }
}

class _MCoreWidget extends StatelessWidget {
  final WidgetSerializer serializer;
  _MCoreWidget(this.serializer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}

class MContainer extends _MCoreWidget {
  MContainer(WidgetSerializer serializer) : super(serializer);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: serializer.padding,
      margin: serializer.margin,
      width: serializer.width,
      height: serializer.height,
      alignment: serializer.alignment,
      decoration: BoxDecoration(
          color: serializer.color,
          borderRadius: BorderRadius.circular(serializer.cornerRadiu)),
      child: MWidgetGeneractor.generacte(serializer.child),
    );
  }
}

class MText extends _MCoreWidget {
  MText(WidgetSerializer serializer) : super(serializer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      serializer.text,
      style: TextStyleGeneractor(serializer.textStyle),
    );
  }
}

class MImage extends _MCoreWidget {
  MImage(ImageSerializer serializer) : super(serializer);

  ImageSerializer get imgserializer => serializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return imgserializer.assetImg != null
        ? Image.asset(imgserializer.assetImg)
        : imgserializer.imgUrl != null
            ? Image.network(imgserializer.imgUrl)
            : Container();
  }
}

class MTextField extends StatefulWidget {
  final TextFieldSerializer serializer;
  MTextField(this.serializer);
  @override
  _MTextFieldState createState() => _MTextFieldState();
}

class _MTextFieldState extends State<MTextField> {
  TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _textEditingController =
        TextEditingController(text: widget.serializer.editingText ?? "");
  }

  @override
  void dispose() {
    super.dispose();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLength: widget.serializer.maxLength,
      maxLines: widget.serializer.maxlines,
      obscureText: widget.serializer.obscureText,
      autofocus: widget.serializer.autoFocused,
      onChanged: (String editingStr) {
        widget.serializer.editingText = editingStr;
      },
    );
  }
}

class MFlexble extends _MCoreWidget {
  MFlexble(MultiChildrenSerializer multiChildrenSerializer)
      : super(multiChildrenSerializer);

  MultiChildrenSerializer get multiChildrenSerializer =>
      serializer as MultiChildrenSerializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Flex(
      direction: multiChildrenSerializer.direction,
      mainAxisAlignment: multiChildrenSerializer.mainAxisAlignment,
      crossAxisAlignment: multiChildrenSerializer.crossAxisAlignment,
      mainAxisSize: multiChildrenSerializer.mainAxisSize,
      children: multiChildrenSerializer.children
          .map((var serializer) => MWidgetGeneractor.generacte(serializer))
          .toList(),
    );
  }
}

class MRow extends _MCoreWidget {
  MRow(MultiChildrenSerializer serializer) : super(serializer);

  MultiChildrenSerializer get multiChildrenSerializer =>
      serializer as MultiChildrenSerializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: multiChildrenSerializer.mainAxisAlignment,
      crossAxisAlignment: multiChildrenSerializer.crossAxisAlignment,
      mainAxisSize: multiChildrenSerializer.mainAxisSize,
      children: multiChildrenSerializer.children
          .map((var serializer) => MWidgetGeneractor.generacte(serializer))
          .toList(),
    );
  }
}

class MColumn extends _MCoreWidget {
  MColumn(MultiChildrenSerializer serializer) : super(serializer);

  MultiChildrenSerializer get multiChildrenSerializer =>
      serializer as MultiChildrenSerializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: multiChildrenSerializer.mainAxisAlignment,
      crossAxisAlignment: multiChildrenSerializer.crossAxisAlignment,
      mainAxisSize: multiChildrenSerializer.mainAxisSize,
      children: multiChildrenSerializer.children
          .map((var serializer) => MWidgetGeneractor.generacte(serializer))
          .toList(),
    );
  }
}

class MButton extends _MCoreWidget {
  MButton(
    ButtonSerializer serializer,
  ) : super(serializer);

  ButtonSerializer get butSerializer => serializer;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MWidgetGeneractor.generacte(serializer.child),
      onTap: butSerializer == null
          ? () {
              print(" ------ 方法为空,请检查序列化 ------ ");
            }
          : butSerializer.ontap.doactions,
    );
  }
}

class MScafford extends _MCoreWidget {
  MScafford(ScaffordSerializer serializer) : super(serializer);

  ScaffordSerializer get scaffordSerializer => serializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          leading: MWidgetGeneractor.generacte(scaffordSerializer.leading),
          title: MWidgetGeneractor.generacte(scaffordSerializer.title),
          actions: (scaffordSerializer.actions ?? [])
              .map((var val) => MWidgetGeneractor.generacte(val))
              .toList()),
      body: MWidgetGeneractor.generacte(scaffordSerializer.body),
    );
  }
}

class MHero extends _MCoreWidget {
  MHero(WidgetSerializer serializer) : super(serializer);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Hero(
      tag: serializer.tag,
      child: MWidgetGeneractor.generacte(serializer.child),
    );
  }
}

class MFutureWidget extends _MCoreWidget {
  MFutureWidget(FutureBuilderSerializer serializer) : super(serializer);

  FutureBuilderSerializer get futureBuilderSerializer => serializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FutureBuilder(
      future: futureBuilderSerializer.future.doactions(),
    );
  }
}

class MStack extends _MCoreWidget {
  MStack(StackSerializer serializer) : super(serializer);

  StackSerializer get stackSerializer => serializer;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Stack(
      children: stackSerializer.children
          .map((var val) => MWidgetGeneractor.generacte(val))
          .toList(),
    );
  }
}

class MStatelessWidget extends _MCoreWidget {
  MStatelessWidget(StatelessSerializer serializer) : super(serializer) {}

  StatelessSerializer get statelessSerializer => serializer;

  /// 属性
  Map<String, VariableSerializer> get properties =>
      statelessSerializer.propertys;

  /// 方法列表
  Map<String, MethodSerializer> get methodlists => statelessSerializer.methods;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MWidgetGeneractor.generacte(statelessSerializer.build,
        properties: properties, methods: methodlists);
  }
}
