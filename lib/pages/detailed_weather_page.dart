import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/model/weather_model.dart'; 

class WeatherDetailPage extends StatelessWidget {
  final Weather weather;

  const WeatherDetailPage({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${weather.cityName} Weather',style: GoogleFonts.lato(fontWeight: FontWeight.w600)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                '${weather.temperature.toStringAsFixed(1)}°C',
                style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 48),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                weather.mainCondition,
                style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 24),
              ),
            ),
            const Divider(height: 32),
            WeatherInfoRow(label: 'Feels Like', value: '${weather.feelsLike.toStringAsFixed(1)}°C'),
            WeatherInfoRow(label: 'Humidity', value: '${weather.humidity.toStringAsFixed(0)}%'),
            WeatherInfoRow(label: 'Wind Speed', value: '${weather.windSpeed.toStringAsFixed(1)} m/s'),
          ],
        ),
      ),
    );
  }
}

class WeatherInfoRow extends StatelessWidget {
  final String label;
  final String value;

  const WeatherInfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 18)),
          Text(value, style: GoogleFonts.lato(fontWeight: FontWeight.w600, fontSize: 18)),
        ],
      ),
    );
  }
}
