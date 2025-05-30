import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/model/weather_model.dart';

class WeatherInfo extends StatelessWidget {
  const WeatherInfo({super.key, required this.weather});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          WeatherInfoTile(title: 'Feels Like', value: '${weather.feelsLike}°C'),
          WeatherInfoTile(title: 'Humidity', value: '${weather.humidity}%'),
          WeatherInfoTile(title: 'Wind', value: '${weather.windSpeed}km/h'),
        ],
      ),
    );
  }
}

class WeatherInfoTile extends StatelessWidget {
  const WeatherInfoTile({super.key, required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: GoogleFonts.lato(fontWeight: FontWeight.normal, fontSize: 14),
        ),
        Text(
          value,
          style: GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }
}
