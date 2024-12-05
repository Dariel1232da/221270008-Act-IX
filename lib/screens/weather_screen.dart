import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherScreen extends StatefulWidget {
  final bool fetchByCoordinates;

  WeatherScreen({required this.fetchByCoordinates});

  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  WeatherModel? _weather;
  final TextEditingController _inputController = TextEditingController();

  void _fetchWeather() async {
    WeatherModel? weather;
    if (widget.fetchByCoordinates) {
      final lat = double.tryParse(_inputController.text.split(',')[0]);
      final lon = double.tryParse(_inputController.text.split(',')[1]);
      if (lat != null && lon != null) {
        weather = await _weatherService.fetchWeatherByCoordinates(lat, lon);
      }
    } else {
      weather = await _weatherService.fetchWeatherByCityName(_inputController.text);
    }

    setState(() {
      _weather = weather;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fetchByCoordinates ? 'Weather by Coordinates' : 'Weather by City Name'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: widget.fetchByCoordinates ? 'Enter lat,lon' : 'Enter city name',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchWeather,
              child: Text('Fetch Weather'),
            ),
            SizedBox(height: 16),
            _weather != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Main: ${_weather!.main}'),
                      Text('Description: ${_weather!.description}'),
                      Text('Temperature: ${_weather!.temperature}°C'),
                      Text('Pressure: ${_weather!.pressure} hPa'),
                      Text('Humidity: ${_weather!.humidity}%'),
                    ],
                  )
                : Text('No data'),
          ],
        ),
      ),
    );
  }
}