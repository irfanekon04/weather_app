import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/constants.dart';
import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/model/weather_model.dart';
import 'package:weather_app/pages/detailed_weather_page.dart';
import 'package:weather_app/pages/weather_page.dart';
import 'package:weather_app/services/weather_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  Weather? _weather;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    try {
      print(" getting current city...");
      final weatherService = WeatherService('c3c43192815e03fe2b535ade7b7229ca');
      final city = await weatherService.getCurrentCity();
      print("current city: $city");

      print("Fetching weather...");
      final weather = await weatherService.getWeather(city);
      print("Weather fetched: ${weather.temperature}°C");
      setState(() {
        _weather = weather;
        _isLoading = false;
      });
    } catch (e) {
      print('Failed to load weather: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      const WeatherPage(),
      _isLoading
          ? const Center(child: CircularProgressIndicator())
          : (_weather != null
              ? WeatherDetailPage(weather: _weather!)
              : const Center(child: Text('Weather data not available'))),
    ];

    final _destinations = [
      NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home_rounded, color: Colors.grey),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.wb_sunny_outlined),
        selectedIcon: Icon(Icons.wb_sunny_rounded, color: Colors.grey),
        label: 'Details',
      ),
    ];

    // final _screens = [
    //   const WeatherPage(),
    //   const Center(child: Text('Search')),
    //   WeatherDetailPage(weather: widget.weather),
    //   const Center(child: Text('Settings')),
    // ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              isDarkMode.value = !isDarkMode.value;
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool(Kconstants.themeModeKey, isDarkMode.value);
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
      ),
      body: screens[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.transparent,
        destinations: _destinations,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _currentPageIndex,
        indicatorColor: Theme.of(context).colorScheme.secondary,
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
