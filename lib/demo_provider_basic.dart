import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DemoBasicProvider extends StatefulWidget {
  const DemoBasicProvider({Key? key}) : super(key: key);

  @override
  _DemoBasicProviderState createState() => _DemoBasicProviderState();
}

class _DemoBasicProviderState extends State<DemoBasicProvider> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo Basic Provider"),
      ),
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Center(
          child: OngBaWidget(
            child: ChaMeWidget(
              child: ConCaiWidget(),
            ),
          )
        )
      ),
    );
  }
}


class OngBaWidget extends StatefulWidget {
  Widget child;

  OngBaWidget({required this.child}) : super(key: UniqueKey());

  @override
  State<OngBaWidget> createState() => _OngBaWidgetState();
}

class _OngBaWidgetState extends State<OngBaWidget> {
  String text = "Hello";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Ong ba widget"),
          Provider.value(
              value: text,
              child: widget.child,
          )
        ],
      ),
    );
  }
}

class ChaMeWidget extends StatelessWidget {

  Widget child;

  ChaMeWidget({required this.child}) : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("Cha me widget"),
          child
        ],
      ),
    );
  }
}

class ConCaiWidget extends StatelessWidget {

  ConCaiWidget() : super(key: UniqueKey());

  @override
  Widget build(BuildContext context) {
    return Consumer<String>(
        builder: (context , text , child){
          return Container(
            child: Column(
              children: [
                Text("Con cai widget"),
                Text("Data from parent : $text")
              ],
            ),
          );
        }
    );
  }
}



