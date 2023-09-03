import 'package:flutter/material.dart';
import 'package:simpler_weather_app_flutter/logic/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // future: myData!,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          //if data has any errors
          if (snapshot.hasError) {
            return Center(
              child: Text(
                '${snapshot.error.toString()} Occured',
                style: const TextStyle(fontSize: 18),
              ),
            );
          } //if there is some data recieved
          else if (snapshot.hasData) {
            //first extract data from snapshot
            final data = snapshot.data as WeatherModel;

            return Container();
          }
        }
      },
    );
  }
}
