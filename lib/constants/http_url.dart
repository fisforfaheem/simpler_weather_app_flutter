// ignore_for_file: unused_import

import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;
import 'package:simpler_weather_app_flutter/constants/api_key.dart';
import 'package:simpler_weather_app_flutter/logic/models/weather_model.dart';
// https://api.openweathermap.org/data/2.5/weather?q=Dubai&units=metric&appid='your api key'

class CallToApi {
  Future<WeatherModel> callWeatherAPi(bool current, String cityName) async {
    try {
      // Position currentPosition = await getCurrentPosition();

      if (current) {
        // List<Placemark> placemarks = await placemarkFromCoordinates(
        //     currentPosition.latitude, currentPosition.longitude);

        // Placemark place = placemarks[0];
        cityName = 'Rawalpindi';
      }

      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather',
          {'q': cityName, "units": "metric", "appid": apiKey});
      final http.Response response = await http.get(url);
      log(response.body.toString());

//Means if successful
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return WeatherModel.fromMap(decodedJson);
      } else {
        throw Exception('Failed to load weather Data!');
      }
    } catch (e) {
      throw Exception('Failed to Load Weather Data!!');
    }
  }

  // Future<Position> getCurrentPosition() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();

  //   if (!serviceEnabled) {
  //     return Future.error('Location Services are disbaled!');
  //   }
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       return Future.error("permission is denied!");
  //     }
  //   }
  //   if (permission == LocationPermission.deniedForever) {
  //     return Future.error("Pemission for location denied forever");
  //   }

  //   return await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.best,
  //   );
  // }
}
