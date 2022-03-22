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

class TextData extends ChangeNotifier{
  late String data;

  TextData({required this.data});

  void changeText(String text){
    data = text;
    notifyListeners();
  }
}

class DemoChangeNotifierWidget extends StatelessWidget {

  DemoChangeNotifierWidget() : super(key: UniqueKey());

  Count count = Count(value: 0);
  TextData textData = TextData(data: "Hello");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Demo ChangeNotifier Provider"),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(value: count),
          ChangeNotifierProvider.value(value: textData),
        ],
        child: Consumer<TextData>(
          builder: (context, text , child){
            return Container(
                constraints: BoxConstraints.expand(),
                child: Column(
                  children: [
                    Text(text.data),
                    ElevatedButton(
                        onPressed: (){
                          // data.inCrease();
                        },
                        child: Text("+"))
                  ],
                )
            );
          },
        )
      )
    );
  }
}

