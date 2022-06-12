import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/logic/anmaldCubit/anmald_cubit.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screen';

  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool anmald = false;
  bool countdown = true;

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();

    Future.delayed(const Duration(seconds: 0), () async {
      // await for the Firebase initialization to occur
      setState(() {
        anmald = authService.isAnmald();
      });
    });

    return Padding(
      padding: const EdgeInsets.fromLTRB(36, 60, 36, 20),
      child: Column(
        children: [
          const SizedBox(
            child: Text(
              "FIL-LAN ANMÄLAN ÖPPNAR OM:",
              style: Fil_LanTheme.hdlbTextStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CountdownTimer(
              widgetBuilder: (context, time) {
                if (time == null) {
                  setState(() {
                    countdown = true;
                  });
                  return const Text(
                    "Anmälan Öppen",
                    style: Fil_LanTheme.hdllTextStyle,
                  );
                } else {
                  return Text(
                    "${time.days}d ${time.hours}h ${time.min}m ${time.sec}s",
                    style: Theme.of(context).textTheme.headline2,
                  );
                }
              },
              textStyle: Fil_LanTheme.hdllTextStyle,
              endTime:
                  DateTime.parse("2022-07-30 23:59:59Z").millisecondsSinceEpoch,
            ),
          ),
          countdown
              ? anmald
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(70, 100, 70, 0),
                      child: Text(
                        'Du är anmäld',
                        style: Fil_LanTheme.hdllTextStyle,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
                      child: TextButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Anmäl dig',
                              style: Fil_LanTheme.hdllTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        onPressed: () {
                          anmald
                              ? anmald
                              : Navigator.of(context)
                                  .pushNamed('/anmalan_screen');
                        },
                      ),
                    )
              : const SizedBox(),
        ],
      ),
    );
  }
}


/*
 anmald
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(70, 100, 70, 0),
                  child: Text(
                    'Du är anmäld',
                    style: Fil_LanTheme.hdllTextStyle,
                  ),
                )
              : countdown
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(50, 100, 50, 0),
                      child: TextButton(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: const [
                            Text(
                              'Anmäl dig',
                              style: Fil_LanTheme.hdllTextStyle,
                              textAlign: TextAlign.center,
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        onPressed: () {
                          setState(() {
                            anmald = authService.isAnmald();
                          });
                          anmald
                              ? anmald
                              : Navigator.of(context)
                                  .pushNamed('/anmalan_screen');
                        },
                      ),
                    )
                  : const SizedBox(),

                  */