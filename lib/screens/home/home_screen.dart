import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home-screen';
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 60, 36, 20),
      child: Column(
        children: [
          SizedBox(
            child: Text(
              "FIL-LAN ANMÄLAN ÖPPNAR OM:",
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CountdownTimer(
              widgetBuilder: (context, time) {
                if (time == null) {
                  return Text(
                    "Anmälan Öppen",
                    style: Theme.of(context).textTheme.headline2,
                  );
                } else {
                  return Text(
                    "${time.days}d ${time.hours}h ${time.min}m ${time.sec}s",
                    style: Theme.of(context).textTheme.headline2,
                  );
                }
              },
              textStyle: Theme.of(context).textTheme.headline2,
              endTime:
                  DateTime.parse("2022-03-28 23:59:59Z").millisecondsSinceEpoch,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(70, 100, 70, 0),
            child: TextButton(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Anmäl dig',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    Icon(Icons.arrow_forward_ios),
                  ],
                ),
                onPressed: () =>
                    Navigator.of(context).pushNamed('/anmalan_screen')),
          ),
        ],
      ),
    );
  }
}
