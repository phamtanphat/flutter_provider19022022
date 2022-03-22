import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class Count extends ChangeNotifier{
  late int value;
  Count({required this.value});

  void inCrease(){
    value += 1;
    notifyListeners();
  }
}

class DemoChangeNotifierWidget extends StatelessWidget {

  DemoChangeNotifierWidget() : super(key: UniqueKey());

  Count count = Count(value: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo ChangeNotifier Provider"),
      ),
      body: ChangeNotifierProvider.value(
        value: count,
        child: Consumer<Count>(
          builder: (context, data , child){
            return Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: [
                    Text("Value : ${data.value}"),
                    ElevatedButton(
                        onPressed: (){
                          data.inCrease();
                        },
                        child: Text("+"))
                  ],
                )
            );
          },
        )
      ),
    );
  }
}

