import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/data/constants.dart';
import 'package:weather_app/data/notifiers.dart';
import 'package:weather_app/pages/weather_page.dart';
// import 'package:weather_app/views/weather_info.dart';

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
      selectedIcon: Icon(Icons.home_rounded, color: Colors.black),
      label: 'Home',
    ),
    NavigationDestination(
      icon: Icon(Icons.search_outlined),
      selectedIcon: Icon(Icons.search_rounded, color: Colors.black),
      label: 'Search',
    ),
    NavigationDestination(
      icon: Icon(Icons.wb_sunny_outlined),
      selectedIcon: Icon(Icons.wb_sunny_rounded, color: Colors.black),
      label: 'Weather',
    ),
    NavigationDestination(
      icon: Icon(Icons.settings_outlined),
      selectedIcon: Icon(Icons.settings_rounded, color: Colors.black),
      label: 'Settings',
    ),
  ];

  final _screens = [
    const WeatherPage(),
    const Center(child: Text('Search')),
    const WeatherPage(),
    const Center(child: Text('Settings')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(
        //   'Home Screen',
        //   style: GoogleFonts.lato(fontWeight: FontWeight.w600),
        // ),
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
      // drawer: Drawer(
      //   child: SafeArea(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //       children: [
      //         TextButton(
      //           onPressed: () {},
      //           child: Text(
      //             'This is a button',
      //             style: GoogleFonts.lato(fontWeight: FontWeight.w800),
      //           ),
      //         ),
      //         Text(
      //           'It does not do anything',
      //           style: GoogleFonts.lato(fontWeight: FontWeight.w800),
      //         ),
      //         Image(image: AssetImage('assets/icon/icon.png')),
      //         Text(
      //           'this is a test image',
      //           style: GoogleFonts.lato(fontWeight: FontWeight.w800),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      body: _screens[_currentPageIndex],
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
