import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/screens/Anmalan/anmalan.dart';
import 'package:fil_lan/screens/Anmalan/book_table.dart';
import 'package:fil_lan/service/seat_firebase.dart';
import 'package:fil_lan/screens/home/bottom_nav_screen.dart';
import 'package:fil_lan/screens/home/home_screen.dart';
import 'package:fil_lan/screens/home/profile_screen.dart';
import 'package:fil_lan/screens/home/studio_screen.dart';
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
    SeatFire seatService = Provider.of<SeatFire>(context, listen: false);

    Future.delayed(const Duration(seconds: 1), () async {
      // await for the Firebase initialization to occur

      seatService.getSeatsFromFirebas((e) {}).then((value) {
        seats = seatService.getTables();
      });
    });
    Color back = Color(0xff212021);

    Color orange = Color(0xffFBBB78);
    Color blue = Color(0xff1ca3ae);
    Color pink = Color(0xfff8a29f);
    Color error = Color(0xffFF4566);
    Color text = Color(0xff595959);
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: back,
        primarySwatch: createMaterialColor(pink),
        primaryColor: pink,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: back,
            selectedLabelStyle: TextStyle(
              color: pink,
            )),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(),
        ),
        colorScheme: ColorScheme(
            primary: pink,
            primaryVariant: pink,
            secondary: orange,
            secondaryVariant: orange,
            surface: blue,
            background: back,
            error: error,
            onPrimary: text,
            onSecondary: text,
            onSurface: text,
            onBackground: Colors.white,
            onError: Colors.white,
            brightness: Brightness.dark),
        dialogTheme: DialogTheme(
          backgroundColor: blue,
          titleTextStyle: GoogleFonts.lato(
            textStyle: TextStyle(
              color: text,
              fontSize: 20,
            ),
          ),
        ),
        textTheme: TextTheme(
          headline1: GoogleFonts.lato(
            textStyle: TextStyle(
              color: text,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          headline2: GoogleFonts.lato(
            textStyle: TextStyle(
              color: text,
              fontSize: 30,
            ),
          ),
          bodyText2: TextStyle(
            color: text,
          ),
        ),
      ),
      routes: {
        '/': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: const BottomNavScreen(),
            ),
        '/home_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: const HomeScreen(),
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
        '/book_screen': (ctx) => BlocProvider.value(
              value: _blocSeater,
              child: BookTable(seats: seats),
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
