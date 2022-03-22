import 'dart:math';

import 'package:flutter/material.dart';
class DemoBasicProvider extends StatefulWidget {
  const DemoBasicProvider({Key? key}) : super(key: key);

  @override
  _DemoBasicProviderState createState() => _DemoBasicProviderState();
}

class _DemoBasicProviderState extends State<DemoBasicProvider> {

  List<Widget> listWidget = [
    Padding(padding: EdgeInsets.all(5) , child: ColorWidget(key: GlobalKey(),)),
    Padding(padding: EdgeInsets.all(5) , child: ColorWidget(key: GlobalKey(),)),
  ];

  void swapColor(){
    setState(() {
      listWidget.insert(1, listWidget.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Key"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          swapColor();
        },
        child: Icon(Icons.swap_horiz_outlined),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: listWidget
        ),
      ),
    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }
}

class ColorWidget extends StatefulWidget {

  ColorWidget({required Key key}) : super(key: key);

  @override
  _ColorWidgetState createState() => _ColorWidgetState();
}

class _ColorWidgetState extends State<ColorWidget> {
  final Color color = Color.fromARGB(
      255,
      Random.secure().nextInt(255),
      Random.secure().nextInt(255),
      Random.secure().nextInt(255)
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 100,
      height: 100,
    );
  }
}

