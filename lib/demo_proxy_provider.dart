import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiService1 {
  String callApi() {
    var random = Random();
    if (random.nextBool()) {
      return "Call api success";
    } else {
      return "Fail exception";
    }
  }
}

class Repository {
  late ApiService1 apiService;

  Repository();

  void updateApiService({ApiService1? apiService}) {
    this.apiService = apiService!;
  }

  void handleRequest() {
    apiService.callApi();
  }
}

class DemoController {
  late Repository repository;

  DemoController();

  void updateRepository({Repository? repository}) {
    this.repository = repository!;
  }

  void performRequest() {
    repository.handleRequest();
  }
}

class DemoProxyProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Demo Proxy"),
        ),
        body: MultiProvider(providers: [
          Provider(create: (context) => ApiService1()),
          ProxyProvider<ApiService1, Repository>(
            create: (context) => Repository(),
            update: (context, apiService, repository) {
              repository!.updateApiService(apiService: apiService);
              return repository;
            },
          ),
          ProxyProvider<Repository, DemoController>(
            create: (context) => DemoController(),
            update: (context, repository, controller) {
              controller!.updateRepository(repository: repository);
              return controller;
            },
          )
        ], child: DemoProxyContainer()));
  }
}

class DemoProxyContainer extends StatelessWidget {
  StreamController<String> data = StreamController();

  @override
  Widget build(BuildContext context) {
    DemoController controller = Provider.of(context);
    data.sink.add(controller.repository.apiService.callApi());
    return Consumer<DemoController>(
      builder: (context , controller , child){
        return Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder<String>(
                  stream: data.stream,
                  initialData: "",
                  builder: (context , snapshot){
                    if(snapshot.hasError){
                      return Text(snapshot.error.toString());
                    }
                    if(snapshot.hasData){
                      return Text(snapshot.data.toString());
                    }
                    return SizedBox();
                  }
              ),
              ElevatedButton(
                  onPressed: (){
                    data.sink.add(controller.repository.apiService.callApi());
                  },
                  child: Text("Call Api")
              )
            ],
          ),
        );
      },
    );
  }
}
