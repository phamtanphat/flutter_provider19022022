import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_provider19022022/weather_app/api_service.dart';
import 'package:flutter_provider19022022/weather_app/dio_client.dart';
import 'package:flutter_provider19022022/weather_app/models/weather_reponse.dart';
import 'package:flutter_provider19022022/weather_app/weather_controller.dart';
import 'package:flutter_provider19022022/weather_app/weather_repository.dart';
import 'package:provider/provider.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => ApiService()),
        ProxyProvider<ApiService, WeatherRepository>(
          create: (context) => WeatherRepository(),
          update: (context, apiService, repository) {
            repository!.updateApiService(apiService: apiService);
            return repository;
          },
        ),
        ProxyProvider<WeatherRepository, WeatherController>(
          create: (context) => WeatherController(),
          update: (context, repository, controller) {
            controller!.updateRepository(repository: repository);
            return controller;
          },
        )
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text("Weather Screen"),
          ),
          body: WeatherScreenContainer()),
    );
  }
}

class WeatherScreenContainer extends StatefulWidget {
  const WeatherScreenContainer({Key? key}) : super(key: key);

  @override
  State<WeatherScreenContainer> createState() => _WeatherScreenContainerState();
}

class _WeatherScreenContainerState extends State<WeatherScreenContainer> {
  late double width, height;
  late WeatherController controller;
  late TextEditingController _searchController = TextEditingController();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    controller = Provider.of(context);

    Future.delayed(Duration(seconds: 2), () {
      controller.getTempCity("Hanoi");
    });
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
          child: Consumer<WeatherController>(
            builder: (context, controller, child) {
              return LayoutBuilder(builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            searchBox(),
                            StreamBuilder<WeatherResponse>(
                              initialData: null,
                              stream: controller.responseController.stream,
                              builder: (context, snapshot) {
                                if (snapshot.hasError) {
                                  return Container(
                                    constraints: BoxConstraints(
                                        minHeight: constraint.maxHeight),
                                    child: Center(
                                      child: Text(snapshot.error.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 30)),
                                    ),
                                  );
                                }
                                if (snapshot.hasData) {
                                  return Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                            flex: 5,
                                            child: tempCity(snapshot.data)),
                                        Expanded(
                                            flex: 2,
                                            child: detailTemp(snapshot.data))
                                      ],
                                    ),
                                  );
                                }
                                return Expanded(
                                    child: Center(
                                        child: CircularProgressIndicator(
                                  color: Colors.white,
                                )));
                              },
                            )
                          ]),
                    ),
                  ),
                );
              });
            },
          )),
    );
  }

  Widget searchBox() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        hintText: "Input city name",
        suffixIcon: IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              String cityName = _searchController.text.toString();
              if (cityName.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("City name is empty")));
                return;
              }
              Future.delayed(Duration(seconds: 1), () {
                controller.getTempCity(cityName);
              });
            }),
      ),
    );
  }

  Widget tempCity(WeatherResponse? response) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${response?.main?.temp} \u00BA C",
          style: TextStyle(color: Colors.yellow, fontSize: width / 6),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text("${response?.name},${response?.sys?.country}",
            style: TextStyle(color: Colors.white, fontSize: width / 10)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              "https://openweathermap.org/img/wn/${response?.weather?[0].icon}@2x.png",
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.width / 3,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              width: 5,
            ),
            Text("${response?.weather?[0].description}",
                style: TextStyle(
                    fontSize: width / 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 107, 106, 102)))
          ],
        )
      ],
    );
  }

  Widget detailTemp(WeatherResponse? response) {
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
                  Text("${response?.main?.humidity}",
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
                  Text("${response?.wind?.speed}",
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
                  Text("${response?.main?.pressure}",
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
