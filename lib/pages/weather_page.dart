import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService('c3c43192815e03fe2b535ade7b7229ca');
  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();

    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/animations/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'clouds':
        return 'assets/animations/cloudy.json';
      case 'mist':
        return 'assets/animations/mist.json';
      case 'smoke':
        return 'assets/animations/smoke.json';
      case 'haze':
        return 'assets/animations/haze.json';
      case 'dust':
        return 'assets/animations/smoke.json';
      case 'fog':
        return 'assets/animations/smoke.json';
      case 'rain':
        return 'assets/animations/rainy.json';
      case 'drizzle':
        return 'assets/animations/rainy.json';
      case 'shower rain':
        return 'assets/animations/rainy.json';
      case 'thunderstorm':
        return 'assets/animations/thunder.json';
      case 'clear':
        return 'assets/animations/sunny.json';
      default:
        return 'assets/animations/cloudy.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Weather',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isDarkMode.value = !isDarkMode.value;
            },
            icon: ValueListenableBuilder(
              valueListenable: isDarkMode,
              builder: (context, isDarkMode, child) {
                return Icon(
                  isDarkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                );
              },
            ),
          ),
        ],
        // backgroundColor: Colors.blueGrey,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${_weather?.temperature.round()}°C',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w800,
                fontSize: 60,
              ),
            ),
            Text(
              _weather?.cityName ?? "loading city...",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w500,
                fontSize: 25,
                fontStyle: FontStyle.italic,
              ),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              _weather?.mainCondition ?? "",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
