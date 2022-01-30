import 'package:fil_lan/screens/home/home_screen.dart';
import 'package:fil_lan/screens/home/profile_screen.dart';
import 'package:fil_lan/screens/home/studio_screen.dart';
import 'package:flutter/material.dart';

class BottomNavScreen extends StatefulWidget {
  static const routeName = '/bottom-nav-screen';
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  _BottomNavScreenState createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  final List _pages = [
    HomeScreen(),
    StudioScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        selectedLabelStyle:
            TextStyle(color: Theme.of(context).colorScheme.primary),
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              "assets/FIL-LAN22.png",
              height: 30,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            activeIcon: Image.asset(
              "assets/FIL-LAN22.png",
              height: 30,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: 'Home',
            tooltip: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Studio',
            tooltip: 'Studio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
            tooltip: 'Profile',
          ),
        ],
      ),
    );
  }
}
