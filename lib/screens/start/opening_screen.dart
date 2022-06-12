import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';

class OpeningScreen extends StatelessWidget {
  OpeningScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logo = Image.asset(
      "assets/milk-box.png",
      height: mq.size.height / 4,
    );
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: mq.size.height / 6),
              child: logo,
            ),
            Padding(
              padding: EdgeInsets.only(top: mq.size.height / 12),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ButtonTile(
                        text: 'Logga in', route: '/login-screen', mq: mq),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: ButtonTile(
                        text: 'Skapa Konto', route: '/register-screen', mq: mq),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonTile extends StatelessWidget {
  final double? fontSize;
  final Color? buttonColor;
  final Color? textColor;
  final String? route;
  final void Function()? onpressed;
  final MediaQueryData mq;
  final String text;

  const ButtonTile({
    Key? key,
    this.fontSize,
    this.textColor,
    this.buttonColor,
    required this.text,
    required this.route,
    this.onpressed,
    required this.mq,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(25.0),
      color: buttonColor ?? Fil_LanTheme.orange,
      child: MaterialButton(
        minWidth: mq.size.width / 1.5,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fontSize ?? 20.0,
            color: textColor ?? Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          Navigator.pushNamed(context, route!);

          //print('loggedin');
        },
      ),
    );
  }
}
