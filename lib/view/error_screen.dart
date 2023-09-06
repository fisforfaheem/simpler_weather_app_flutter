import 'package:flutter/material.dart';
import 'package:simpler_weather_app_flutter/view/weather_page.dart';

class ErrorScreen extends StatelessWidget {
  final String errorMessage;

  const ErrorScreen({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // '$errorMessage City Not Found',

          const Text(
            'Oh! Your City Not Found!!, Try Again :)',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const WeatherPage();
              }));
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
