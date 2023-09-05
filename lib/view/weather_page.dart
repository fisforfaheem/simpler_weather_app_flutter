import 'package:anim_search_bar/anim_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:simpler_weather_app_flutter/constants/call.dart';
import 'package:simpler_weather_app_flutter/logic/models/weather_model.dart';
import 'package:simpler_weather_app_flutter/view/error_screen.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  TextEditingController textController = TextEditingController();

  late Future<WeatherModel> _myData;
  @override
  void initState() {
    setState(() {
      _myData = getData(true, "Rawalpindi");
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.black,
        body: FutureBuilder(
          future: _myData,
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              //if data has any errors
              if (snapshot.hasError) {
                return ErrorScreen(
                  errorMessage: snapshot.error.toString(),
                );
              }
              //if there is some data recieved
              else if (snapshot.hasData) {
                //first extract data from snapshot
                final data = snapshot.data as WeatherModel;

                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment(0.8, 1),
                      colors: <Color>[
                        Color.fromARGB(255, 65, 89, 224),
                        Color.fromARGB(255, 83, 92, 215),
                        Color.fromARGB(255, 86, 88, 177),
                        Color(0xfff39060),
                        Color(0xffffb56b),
                      ],
                      tileMode: TileMode.mirror,
                    ),
                  ),
                  height: double.infinity,
                  width: double.infinity,
                  child: SafeArea(
                    child: Column(
                      children: [
                        AnimSearchBar(
                            rtl: true,
                            width: 400,
                            color: Colors.white,
                            textController: textController,
                            suffixIcon: const Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 26,
                            ),
                            onSuffixTap: () async {
                              textController.text == ''
                                  ? debugPrint("No city entered")
                                  : setState(() {
                                      _myData =
                                          getData(false, textController.text);
                                    });
                              FocusScope.of(context).unfocus();
                              textController.clear();
                            },
                            onSubmitted: (value) {
                              debugPrint('User submitted: $value');
                            },
                            style: const TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Colors.black,
                                letterSpacing: 2)),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 25),
                            const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                            ),
                            Text(
                              data.city,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              data.desc,
                              style: const TextStyle(
                                  fontSize: 42,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 25),
                            Text(
                              "${data.temp}°C",
                              style: const TextStyle(
                                  fontSize: 42,
                                  fontFamily: 'Poppins',
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 10,
                    ),
                  ),
                );
              } else {
                return Center(
                  child: Text("State ${snapshot.connectionState}"),
                );
              }
            }
            return const Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 10,
                ),
              ),
            );
          },
        ));
  }
}





// https://medium.com/flutter-community/build-a-realtime-weather-app-in-flutter-using-futurebuilder-90959c47c399