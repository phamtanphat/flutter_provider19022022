import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DemoInheritedWidget extends StatefulWidget {
  @override
  State<DemoInheritedWidget> createState() => _DemoInheritedWidgetState();
}

class _DemoInheritedWidgetState extends State<DemoInheritedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Inherited Widget"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Ongba(
          child: Chame(
            child: Concai(),
          ),
        ),
      ),
    );
  }
}

//Ong ba : state full
class Ongba extends StatefulWidget {
  Widget child;

  Ongba({required this.child});

  String data = "Hello";

  static Ongba? of(BuildContext context){
    return context.findAncestorWidgetOfExactType();
  }

  @override
  State<Ongba> createState() => _OngbaState();
}

class _OngbaState extends State<Ongba> {
  int number = 0;

  @override
  Widget build(BuildContext context) {
    print("Ong ba build");
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Ong ba widget",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          Text("Number : $number",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
          ElevatedButton(
              onPressed: (){
                setState(() {
                  number = Random.secure().nextInt(10);
                });
              },
              child: Text("Random number")
          ),
          MyInheritedWidget(
              child: widget.child,
              value: widget.data
          )
        ],
      ),`
    );
  }
}

class MyInheritedWidget extends InheritedWidget{
  Widget child;
  late String value;

  MyInheritedWidget({required this.child , required this.value}) : super(child: child);

  static MyInheritedWidget? of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType();
  }

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) {
    return oldWidget.value != value;
  }

}

// Cha me : stateless
class Chame extends StatelessWidget {
  Widget child;

  Chame({required this.child});

  @override
  Widget build(BuildContext context) {
    print("Cha me build");
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Cha me widget",
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
          child
        ],
      ),
    );
  }
}

// Concai : stateless
class Concai extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  print("Con cai build");
  MyInheritedWidget? myInheritedWidget = MyInheritedWidget.of(context);
    return Container(
      child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Con cai widget ${myInheritedWidget?.value}",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
