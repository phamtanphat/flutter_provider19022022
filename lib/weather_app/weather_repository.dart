import 'package:flutter_provider19022022/weather_app/api_service.dart';

class WeatherRepository{
  late ApiService _apiService;

  WeatherRepository();

  void updateApiService({required ApiService apiService}){
    this._apiService = apiService;

  }

  Future getTempCity(String cityName){
    return _apiService.getTempCity(cityName);
  }
}