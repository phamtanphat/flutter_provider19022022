import 'package:flutter/material.dart';
import 'package:flutter_provider19022022/demo_inheritedWidget_2.dart';

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
      home: DemoInheritedWidget2(),
    );
  }
}
