import 'package:fil_lan/logic/anmaldCubit/anmald_cubit.dart';
import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/payment/swishtest.dart';
import 'package:fil_lan/service/seat_firebase.dart';

import 'package:fil_lan/screens/start/login_screen.dart';
import 'package:fil_lan/screens/start/opening_screen.dart';
import 'package:fil_lan/screens/start/register_screen.dart';
import 'package:fil_lan/screens/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:provider/provider.dart';
import 'service/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SwishDemoApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color back = Color(0xff212021);

    Color orange = Color(0xffFBBB78);
    Color blue = Color(0xff1ca3ae);
    Color pink = Color(0xfff8a29f);
    Color error = Color(0xffFF4566);
    Color text = Color(0xff595959);

    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
        Provider<SeatFire>(
          create: (_) => SeatFire(),
        ),
        BlocProvider<TableBloc>(create: (context) => TableBloc())
      ],
      child: Builder(builder: (BuildContext context) {
        return MaterialApp(
          theme: ThemeData(
            scaffoldBackgroundColor: orange,
            primarySwatch: createMaterialColor(pink),
            primaryColor: pink,
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
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(),
            ),
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
              bodyText2: TextStyle(
                color: text,
              ),
            ),
          ),
          title: "APP",
          initialRoute: '/',
          routes: {
            '/': (context) => const Wrapper(),
            '/login-screen': (context) => LoginScreen(),
            '/register-screen': (context) => RegisterScreen(),
            '/opening-screen': (context) => OpeningScreen(),
          },
        );
//Here to use rootContext is safe
//Provider.of<SomeModel>(rootContext, listen: false);
      }),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}
