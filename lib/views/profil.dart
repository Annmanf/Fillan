import 'package:fil_lan/src/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../src/authentication.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 50), child: Text("profil"),
            //countdown
          ),
          Text("hej"),
        ],
      ),
    );
  }
}
