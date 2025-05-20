import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/constants.dart';
import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/pages/weather_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentPageIndex = 0;
  final _destinations = [
    NavigationDestination(
      icon: Icon(Icons.home_outlined),
      selectedIcon: Icon(Icons.home_rounded),
      label: 'label',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search_rounded),
      label: 'label',
    ),
    NavigationDestination(
      icon: Icon(Icons.wb_sunny_outlined),
      selectedIcon: Icon(Icons.wb_sunny_rounded),
      label: 'label',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings_rounded),
      label: 'label',
    ),
  ];

  final _screens = [
    const WeatherPage(),
    const Center(child: Text('Search')),
    const Center(child: Text('Weather')),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        ),
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
        // backgroundColor: Colors.blueGrey,
      ),
      body: _screens[_currentPageIndex],
      bottomNavigationBar: NavigationBar(
        destinations: _destinations,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        selectedIndex: _currentPageIndex,
        indicatorColor: Colors.transparent,
        indicatorShape: CircleBorder(),
        onDestinationSelected: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
      ),
    );
  }
}
