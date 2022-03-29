import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_provider19022022/weather_app/models/weather_reponse.dart';
import 'package:flutter_provider19022022/weather_app/weather_repository.dart';

class WeatherController {
  StreamController<WeatherResponse> responseController = StreamController();
  late WeatherRepository _repository;

  WeatherController();

  void updateRepository({required WeatherRepository repository}) {
    this._repository = repository;
  }

  void getTempCity(String cityName) async {
    try {
      Response response = await _repository.getTempCity(cityName);
      if(response.statusCode == 200){
        WeatherResponse weatherResponse = WeatherResponse.fromJson(response.data);
        responseController.sink.add(weatherResponse);
      }
    } on DioError catch(dioError){
      responseController.sink.addError(dioError.response?.data["message"]);
    }catch (e){
      responseController.sink.addError(e.toString());
    }
  }

  void dispose() {
    responseController.close();
  }
}
