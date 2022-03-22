import 'package:flutter/material.dart';
import 'package:flutter_provider19022022/demo_changenotifier_provider.dart';
import 'package:flutter_provider19022022/demo_inheritedWidget_2.dart';
import 'package:flutter_provider19022022/demo_provider_basic.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemoChangeNotifierWidget(),
    );
  }
}
