import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/screens/Anmalan/anmalan.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/screens/home/bottom_nav_screen.dart';
import 'package:fil_lan/screens/home/home_screen.dart';
import 'package:fil_lan/screens/home/profile_screen.dart';
import 'package:fil_lan/screens/home/studio_screen.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatefulWidget {
  StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final TableBloc _blocSeater = TableBloc();

  var seats = [];

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    Future.delayed(const Duration(seconds: 1), () async {
      // await for the Firebase initialization to occur
      /* await seatService.addTablesInFirebase(
          9,
          [
            {0: 1},
            {1: 2},
            {2: 3},
            {3: 4},
            {4: 5}
          ],
          9);*/
      /*
      await seatService.getSeatsFromFirebas((e) {}).then((value) {
        setState(() {
          seats = seatService.getTables();
        });

        //print('fetched tables');
      });*/

      authService.getData();
      //authService.getSelectedSeats();
    });
    Color back = Color(0xff212021);

    Color orange = Color(0xffFBBB78);
    Color blue = Color(0xff1ca3ae);
    Color pink = Color(0xfff8a29f);
    Color error = Color(0xffFF4566);
    Color text = Color(0xff595959);
    return MaterialApp(
      theme: Fil_LanTheme.fil_lanTheme,
      routes: {
        '/': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: const BottomNavScreen(),
            ),
        '/home_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: HomeScreen(),
            ),
        '/profile_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: ProfileScreen(),
            ),
        '/studio_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: const StudioScreen(),
            ),
        '/anmalan_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: Anmalan(seats: seats),
            ),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _blocSeater.close();
    super.dispose();
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}
