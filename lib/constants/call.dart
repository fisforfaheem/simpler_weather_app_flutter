import 'package:simpler_weather_app_flutter/constants/http_url.dart';
import 'package:simpler_weather_app_flutter/logic/models/weather_model.dart';

Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
  return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
}
