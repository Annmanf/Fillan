import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';

class StudioScreen extends StatelessWidget {
  static const routeName = '/studio-screen';
  const StudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 50, 36, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: SizedBox(
                child: Text(
                  "STUDIO",
                  style: FilLanTheme.hdlbTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Center(
              child: SizedBox(
                child: Text(
                  "Kommer snart...",
                  style: FilLanTheme.hddlTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(),
        ],
      ),
    );
  }
}
