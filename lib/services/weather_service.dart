import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';
import '../models/weather_model.dart';

class WeatherService {
  Future<WeatherModel?> fetchWeatherByCoordinates(double lat, double lon) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}?lat=$lat&lon=$lon&appid=${ApiConstants.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      return null;
    }
  }

  Future<WeatherModel?> fetchWeatherByCityName(String cityName) async {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}?q=$cityName&appid=${ApiConstants.apiKey}&units=metric'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherModel.fromJson(data);
    } else {
      return null;
    }
  }
}
