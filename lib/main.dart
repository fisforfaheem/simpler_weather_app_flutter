import 'package:flutter/material.dart';
import 'package:simpler_weather_app_flutter/view/weather_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simpler Weather App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const WeatherPage(),
    );
  }
}
