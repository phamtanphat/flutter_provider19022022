import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_provider19022022/weather_app/models/weather_reponse.dart';
import 'package:flutter_provider19022022/weather_app/weather_repository.dart';

class WeatherController{
  StreamController<WeatherResponse> responseController = StreamController();
  late WeatherRepository _repository;

  WeatherController({required WeatherRepository repository}){
    this._repository = repository;
  }

  void getTempCity(String cityName) async{
    try{
      Response response = await _repository.getTempCity(cityName);
      print(response);
    }catch(e){
      print(e.toString());
    }
  }

  void dispose(){
    responseController.close();
  }
}