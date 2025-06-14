import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:weather_app/data/constants.dart';
// import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:weather_app/views/weather_info.dart';

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
      //m
    }
  }

  String date = DateFormat("yMMMMd").format(DateTime.now());

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
      // appBar: AppBar(
      //   title: Text('', style: GoogleFonts.lato(fontWeight: FontWeight.w600)),
      //   actions: [
      //     IconButton(
      //       onPressed: () async {
      //         isDarkMode.value = !isDarkMode.value;
      //         final SharedPreferences prefs =
      //             await SharedPreferences.getInstance();
      //         await prefs.setBool(Kconstants.themeModeKey, isDarkMode.value);
      //       },
      //       icon: ValueListenableBuilder(
      //         valueListenable: isDarkMode,
      //         builder: (context, isDarkMode, child) {
      //           return Icon(
      //             isDarkMode
      //                 ? Icons.light_mode_rounded
      //                 : Icons.dark_mode_rounded,
      //           );
      //         },
      //       ),
      //     ),
      //   ],
      //   // backgroundColor: Colors.blueGrey,
      // ),
      // drawer: Drawer(
      //   child: SafeArea(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         ElevatedButton(onPressed: () {}, child: Text('This is a button')),
      //         Text('It does not do anything'),
      //         Image(image: AssetImage('assets/icon/icon.png')),
      //         Text('this is a test image'),
      //       ],
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.topLeft,
              child: Text(
                _weather?.cityName ?? "loading city...",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  fontSize: 35,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              alignment: Alignment.topLeft,
              child: Text(
                date,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  fontSize: 14,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
            SizedBox(height: 10),
            Text(
              '${_weather?.temperature.round()}°C',
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w800,
                fontSize: 60,
              ),
            ),
            SizedBox(height: 10),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              _weather?.mainCondition ?? "",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w600,
                fontSize: 30,
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
