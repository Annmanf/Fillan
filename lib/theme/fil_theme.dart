import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Fil_LanTheme {
  static const bgColor = Color(0xff212021);
  static const orange = Color(0xffFBBB78);
  static const blue = Color(0xff1ca3ae);
  static const pink = Color(0xfff8a29f);
  static const error = Color(0xffFF4566);
  static const darkTextColor = Color(0xff595959);
  static const lightTextColor = Color(0xffEDD7BF);
  static const cost = 700;
  static const food = 300;
  //static const lightTextColor = Color(0xfff7ede2);

//dark bold headers
  static const hddbTextStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: darkTextColor);
//light bold headers
  static const hdlbTextStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.bold, color: lightTextColor);

//dark light headers
  static const hddlTextStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.normal, color: darkTextColor);
  //light light headers
  static const hdllTextStyle = TextStyle(
      fontSize: 30, fontWeight: FontWeight.normal, color: lightTextColor);

  static const sdTextStyle =
      TextStyle(fontSize: 16, color: darkTextColor); //for subheaders dark
  static const slTextStyle =
      TextStyle(fontSize: 16, color: lightTextColor); //for subheaders light

// medium button with dark text
  static var butOStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(sdTextStyle),
    backgroundColor: MaterialStateProperty.all(orange),
  );
  static var butPStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(sdTextStyle),
    backgroundColor: MaterialStateProperty.all(pink),
  );
  static var butBStyle = ButtonStyle(
    textStyle: MaterialStateProperty.all(sdTextStyle),
    backgroundColor: MaterialStateProperty.all(blue),
  );

  static var fil_lanTheme = ThemeData(
    scaffoldBackgroundColor: Fil_LanTheme.bgColor,
    primarySwatch: createMaterialColor(pink),
    primaryColor: pink,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: bgColor,
        selectedLabelStyle: TextStyle(
          color: pink,
        )),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(),
    ),
    colorScheme: ColorScheme(
        primary: pink,
        secondary: orange,
        surface: blue,
        background: bgColor,
        error: error,
        onPrimary: lightTextColor,
        onSecondary: darkTextColor,
        onSurface: darkTextColor,
        onBackground: lightTextColor,
        onError: error,
        brightness: Brightness.dark),
    dialogTheme: DialogTheme(
      backgroundColor: blue,
      titleTextStyle: GoogleFonts.lato(
        textStyle: TextStyle(
          color: darkTextColor,
          fontSize: 20,
        ),
      ),
    ),
    textTheme: TextTheme(
        headline1: GoogleFonts.lato(textStyle: hdlbTextStyle),
        headline2: GoogleFonts.lato(textStyle: hdllTextStyle),
        bodyText2: slTextStyle),
  );
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
