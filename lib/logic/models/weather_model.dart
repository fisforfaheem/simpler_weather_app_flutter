class WeatherModel {
  WeatherModel.fromMap(Map<String, dynamic> json)
      : temp = json['main']['temp'].toString(),
        city = json['name'],
        desc = json['weather'][0]['description'];

  final String city;
  final String desc;
  final String temp;
}
