import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_countdown_timer/index.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
          countdown
              ? const Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: SizedBox(
                    child: Text(
                      "ANMÄLAN ÖPPEN",
                      style: FilLanTheme.hdlbTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : const Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: SizedBox(
                    child: Text(
                      "FIL-LAN ANMÄLAN ÖPPNAR OM:",
                      style: FilLanTheme.hdlbTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: CountdownTimer(
              widgetBuilder: (context, time) {
                if (time != null) {
                  if (time.days != null) {
                    return Text(
                      "${time.days}d ${time.hours}h ${time.min}m ${time.sec}s",
                      style: Theme.of(context).textTheme.headline2,
                    );
                  } else if (time.hours != null) {
                    return Text(
                      "${0}d ${time.hours}h ${time.min}m ${time.sec}s",
                      style: Theme.of(context).textTheme.headline2,
                    );
                  } else if (time.min != null) {
                    return Text(
                      "${0}d ${0}h ${0}m ${time.sec}s",
                      style: Theme.of(context).textTheme.headline2,
                    );
                  }
                } else {
                  return Text(
                    "",
                    style: Theme.of(context).textTheme.headline2,
                  );
                }
                return Text(
                  "${time.days}d ${time.hours}h ${time.min}m ${time.sec}s",
                  style: Theme.of(context).textTheme.headline2,
                );
              },
              textStyle: FilLanTheme.hdllTextStyle,
              endTime:
                  DateTime.parse("2022-06-21 23:59:59Z").millisecondsSinceEpoch,
              onEnd: _onTimerEnd(),
            ),
          ),
          countdown
              ? anmald
                  ? const Padding(
                      padding: EdgeInsets.fromLTRB(70, 100, 70, 0),
                      child: Text(
                        'Du är anmäld',
                        style: FilLanTheme.hdllTextStyle,
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
                              style: FilLanTheme.hdllTextStyle,
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
          Expanded(
            child: const Text(
                'Årets feature: boka din egna sittplats för lanet! (Öppnar snart)'),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () => launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.twitch.tv',
                        path: '/studiofillan'),
                  ),
                  icon: Image.asset('assets/discord.png'),
                ),
                IconButton(
                  onPressed: () => launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.twitch.tv',
                        path: '/studiofillan'),
                  ),
                  icon: Image.asset('assets/twitch.png'),
                ),
                IconButton(
                  onPressed: () => launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.instagram.com',
                        path: '/studiofillan'),
                  ),
                  icon: Image.asset('assets/instagram.png'),
                ),
                IconButton(
                  onPressed: () => launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.facebook.com',
                        path: '/taggafillan'),
                  ),
                  icon: Image.asset('assets/facebook.png'),
                ),
                IconButton(
                  onPressed: () => launchUrl(
                    Uri(
                        scheme: 'https',
                        host: 'www.youtube.com',
                        path: '/channel/UC7vzorhoujgSlwJcnXWexqA'),
                  ),
                  icon: Image.asset('assets/youtube.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _onTimerEnd() {
    setState(() {
      countdown = true;
    });
  }
}



/*
 anmald
              ? const Padding(
                  padding: EdgeInsets.fromLTRB(70, 100, 70, 0),
                  child: Text(
                    'Du är anmäld',
                    style: FilLanTheme.hdllTextStyle,
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
                              style: FilLanTheme.hdllTextStyle,
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