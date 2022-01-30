import 'package:fil_lan/models/users.dart';
import 'package:fil_lan/screens/start/opening_screen.dart';
import 'package:fil_lan/screens/home/start_screen.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//inloggad ?
class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return StreamBuilder<User?>(
      stream: authService.user,
      builder: (_, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          User? user = snapshot.data;
          final bool isLoggedin = snapshot.hasData;
          print(isLoggedin);

          return isLoggedin ? StartScreen() : OpeningScreen();
        } else {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
