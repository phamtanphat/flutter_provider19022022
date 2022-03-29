import 'package:flutter_provider19022022/weather_app/models/main.dart';
import 'package:flutter_provider19022022/weather_app/models/sys.dart';
import 'package:flutter_provider19022022/weather_app/models/weather.dart';
import 'package:flutter_provider19022022/weather_app/models/wind.dart';

class WeatherResponse {
  List<Weather>? weather;
  Main? main;
  Wind? wind;
  Sys? sys;
  String? name;
  int? cod;

  WeatherResponse(
      {this.weather,
        this.main,
        this.wind,
        this.sys,
        this.name,
        this.cod});

  WeatherResponse.fromJson(Map<String, dynamic> json) {
    if (json['weather'] != null) {
      weather = [];
      json['weather'].forEach((v) {
        weather!.add(Weather.fromJson(v));
      });
    }
    main = json['main'] != null ? new Main.fromJson(json['main']) : null;
    wind = json['wind'] != null ? new Wind.fromJson(json['wind']) : null;
    sys = json['sys'] != null ? new Sys.fromJson(json['sys']) : null;
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.weather != null) {
      data['weather'] = this.weather!.map((v) => v.toJson()).toList();
    }
    if (this.main != null) {
      data['main'] = this.main!.toJson();
    }
    if (this.wind != null) {
      data['wind'] = this.wind!.toJson();
    }
    if (this.sys != null) {
      data['sys'] = this.sys!.toJson();
    }
    data['name'] = this.name;
    data['cod'] = this.cod;
    return data;
  }
}