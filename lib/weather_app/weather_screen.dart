import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_provider19022022/weather_app/dio_client.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // DioClient dio1 = DioClient.getInstance();
    // DioClient dio2 = DioClient.getInstance();
    //
    // print(dio1 == dio2);

    // Object o1 = Object();
    // Object o2 = Object();
    //
    // print(o1 == o2);

    //json object
    // Map objecta = {
    //   "name" : "Nguyen Van Teo"
    // };
    //
    // //Json array
    // var arr = [
    //   "Teo","Ty","Tun"
    // ];


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Weather Screen"),
        ),
        body: WeatherScreenContainer());
  }
}

class WeatherScreenContainer extends StatefulWidget {
  const WeatherScreenContainer({Key? key}) : super(key: key);

  @override
  State<WeatherScreenContainer> createState() => _WeatherScreenContainerState();
}

class _WeatherScreenContainerState extends State<WeatherScreenContainer> {
  late double width, height;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.lightBlueAccent,
              Colors.blue,
            ],
          )),
          constraints: BoxConstraints.expand(),
          padding: const EdgeInsets.all(5),
          child: LayoutBuilder(builder: (context, constraint) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraint.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        searchBox(),
                        Expanded(flex: 5, child: tempCity()),
                        Expanded(flex: 2, child: detailTemp())
                      ]),
                ),
              ),
            );
          })),
    );
  }

  Widget searchBox() {
    return TextField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: "Input city name",
        suffixIcon: IconButton(icon: Icon(Icons.search), onPressed: () {}),
      ),
    );
  }

  Widget tempCity() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("20 \u00BA C",
            style: TextStyle(color: Colors.yellow, fontSize: width / 4)),
        Text("Hanoi,VN",
            style: TextStyle(color: Colors.white, fontSize: width / 10)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.network(
            //   "https://openweathermap.org/img/wn/${model.weather?[0].icon}@2x.png",
            //   width: widget.width / 2,
            //   height: widget.width / 3,
            //   fit: BoxFit.fitWidth,
            // ),
            SizedBox(
              width: 5,
            ),
            Text("overcast clouds",
                style: TextStyle(
                    fontSize: width / 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 107, 106, 102)))
          ],
        )
      ],
    );
  }

  Widget detailTemp() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Card(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/icon/ic_humidity.png"),
                  Text("91",
                      style: TextStyle(
                          fontSize: width / 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900])),
                  Text("Humidity",
                      style: TextStyle(
                          fontSize: width / 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/icon/ic_wind.png"),
                  Text("2.93",
                      style: TextStyle(
                          fontSize: width / 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900])),
                  Text("Wind",
                      style: TextStyle(
                          fontSize: width / 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          child: Card(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset("assets/icon/ic_air_pressure.png"),
                  Text("1009",
                      style: TextStyle(
                          fontSize: width / 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[900])),
                  Text("Air pressure",
                      style: TextStyle(
                          fontSize: width / 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[500])),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

// Widget notFoundCity() {
//   return Container(
//     constraints: BoxConstraints.expand(),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Image.asset("assets/images/ic_not_found.png"),
//         Text("Seems like you aren't on earth",
//             style:
//             TextStyle(fontSize: widget.width / 23, color: Colors.white)),
//       ],
//     ),
//   );
// }
}
