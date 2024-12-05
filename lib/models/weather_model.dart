class WeatherModel {
  final String main;
  final String description;
  final double temperature;
  final int pressure;
  final int humidity;

  WeatherModel({
    required this.main,
    required this.description,
    required this.temperature,
    required this.pressure,
    required this.humidity,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      main: json['weather'][0]['main'],
      description: json['weather'][0]['description'],
      temperature: json['main']['temp'],
      pressure: json['main']['pressure'],
      humidity: json['main']['humidity'],
    );
  }
}