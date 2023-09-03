import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:simpler_weather_app_flutter/logic/models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController textController = TextEditingController();

  Future<WeatherModel>? _myData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _myData!,
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
          }
          //if there is some data recieved
          else if (snapshot.hasData) {
            //first extract data from snapshot
            final data = snapshot.data as WeatherModel;

            return SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: SafeArea(
                child: Column(
                  children: [
                    AnimSearchBar(
                      width: 400,
                      textController: textController,
                      suffixIcon: const Icon(Icons.search),
                      onSuffixTap: () async {
                        textController.text == ''
                            ? print("No city entered")
                            : setState(() {
                                _myData = getData(false, textController.text);
                              });
                        FocusScope.of(context).unfocus();
                        textController.clear();
                      },
                      onSubmitted: (value) {
                        print('User submitted: $value');
                      },
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_on_rounded,
                          color: Colors.white,
                        ),
                        Text(data.city),
                        const SizedBox(height: 25),
                        Text(data.desc),
                        const SizedBox(height: 25),
                        Text(
                          '{$data.temp}°C',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Text("State ${snapshot.connectionState}"),
            );
          }
        }
        return const Center(
          child: Text("Server Timed out"),
        );
      },
    );
  }
}





// https://medium.com/flutter-community/build-a-realtime-weather-app-in-flutter-using-futurebuilder-90959c47c399