import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiService {
  Future<String> callApi() {
    var random = Random();
    if (random.nextBool()) {
      return Future.value("Call api success");
    } else {
      return Future.error("Fail exception");
    }
  }
}

class Repository {
  late ApiService apiService;

  Repository();

  void updateApiService({ApiService? apiService}) {
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
          Provider(create: (context) => ApiService()),
          ProxyProvider<ApiService, Repository>(
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
  const DemoProxyContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<DemoController>(
      builder: (context , controller , child){
        return Container(
          constraints: BoxConstraints.expand(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<String>(
                  future: controller.repository.apiService.callApi(),
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
              )
            ],
          ),
        );
      },
    );
  }
}
