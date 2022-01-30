import 'package:flutter/material.dart';

class Colors {
  Color orange = Color(0xfffbbb78);
  Color blue = Color(0xff1ca3ae);
  Color pink = Color(0xfff8a29f);
  Color text = Color(0xff595959);

  Colors();

  Color getColor(String x) {
    switch (x) {
      case "orange":
        return orange;

      case "blue":
        return blue;
      case "pink":
        return pink;
      case "text":
        return text;

      default:
        return orange;
    }
  }
}
