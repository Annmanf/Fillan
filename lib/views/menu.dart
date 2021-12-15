import 'package:fil_lan/views/home.dart';
import 'package:fil_lan/views/profil.dart';
import 'package:fil_lan/views/studio.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  MenuScreenState createState() => MenuScreenState();
}

class MenuScreenState extends State<MenuScreen> {
  MenuScreenState();
  int currentIndex = 0;
  final screens = [
    HomeView(),
    Studio(),
    ProfilePage(),
  ];
  var dag = DateTime.now().day;
  var tim = DateTime.now().hour;
  var min = DateTime.now().minute;

  var enddag = 30;
  var endtim = 24;
  var endmin = 0;
  var dur = (30 - DateTime.now().day) * (3 - DateTime.now().month);
  var hur = (24 - DateTime.now().hour);
  var mur = (0 - DateTime.now().minute);
  int sec = 60;
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    startTimer();
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(days: dur, hours: hur, minutes: mur), (_) {
      if (sec > 0) {
        setState(() => hur--);
      } else {
        stopTimer();
      }
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  void HandleTimeout() {}

  @override
  Widget build(BuildContext context) {
    final isRunning = (timer == null ? false : timer!.isActive);

    return Scaffold(
      backgroundColor: const Color(0xff8c52ff),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 200),
            child: CountdownTimer(
              endTime: DateTime.now().day + 30,
            ),
          ),
          IndexedStack(
            children: screens,
            index: currentIndex,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color(0xff8c52ff),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white30,
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Studio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profil',
          ),
        ],
      ),
    );
  }
}
