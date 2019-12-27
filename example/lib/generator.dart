/*
* @auther : Mark
* @date : 2019-12-24
* @ide : VSCode
*/
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hot_widget/hot_widget.dart';

class GenerateWidget extends StatefulWidget {
  @override
  _GenerateWidgetState createState() => _GenerateWidgetState();
}

class _GenerateWidgetState extends State<GenerateWidget> {
  Map configData;

  Future<Map> loadTestConfig() async {
    return configData ??=
        json.decode(await rootBundle.loadString("test/remoteWidget_test.json"));
  }

  @override
  Widget build(BuildContext context) {
    // return MWidgetGeneractor.generacte();
    HotWidgetManager.shareManager.interfaceContext = context;
    return FutureBuilder(
      future: loadTestConfig(),
      builder: (ctx, AsyncSnapshot shot) {
        if (shot.connectionState != ConnectionState.done) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return MWidgetGeneractor.generacte(
              MWidgetSerializer.loadJsonConfig(shot.data));
        }
      },
    );
  }
}
