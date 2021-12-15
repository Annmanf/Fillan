import 'package:fil_lan/main.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'src/authentication.dart';

class OpeningPage extends StatelessWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final logo = Image.asset(
      "assets/milk-box.png",
      height: mq.size.height / 4,
    );
    return Scaffold(
      backgroundColor: const Color(0xff8c52ff),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 30, 12, 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: logo,
            ),
            const SizedBox(height: 8),
            Consumer<LoginView>(
              builder: (context, appState, _) => Authentication(
                email: appState.email,
                loginState: appState.loginState,
                startLoginFlow: appState.startLoginFlow,
                verifyEmail: appState.verifyEmail,
                signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
                cancelRegistration: appState.cancelRegistration,
                registerAccount: appState.registerAccount,
                signOut: appState.signOut,
              ),
            ),
            const Divider(
              height: 8,
              thickness: 1,
              indent: 8,
              endIndent: 8,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
