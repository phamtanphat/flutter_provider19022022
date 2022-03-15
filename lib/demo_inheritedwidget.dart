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
          widget.child
        ],
      ),
    );
  }
}

// Cha me : stateless
class Chame extends StatelessWidget {
  Widget child;

  Chame({required this.child});

  @override
  Widget build(BuildContext context) {
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
    Ongba? ongba = Ongba.of(context);
    return Container(
      child:Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Con cai widget ${ongba?.data}",
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
