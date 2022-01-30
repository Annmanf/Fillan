import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  static String? username = '';
  static String? phonenumber = '';
  static const routeName = '/profile-screen';

  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isSwitched = false;
  List<String> status = ['online', 'offline'];
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final Stream<QuerySnapshot> _usersStream =
        FirebaseFirestore.instance.collection('users').snapshots();
    String? email = authService.email;

    var userData = authService.getData();

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          stretch: true,
          expandedHeight: 250,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Row(
              children: [
                SizedBox(
                  width: 12,
                ),
                CircleAvatar(
                  backgroundColor: Color(0x0000F000),
                ),
                SizedBox(
                  width: 12,
                ),
                Text('Username'),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              primary: false,
              shrinkWrap: true,
              children: [
                const _userTextTile(
                  text: 'Status',
                ),
                _userHeightTile(
                  height: 10,
                ),
                Card(
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.background,
                    leading: Icon(Icons.online_prediction,
                        color: Theme.of(context).colorScheme.secondary),
                    title: Text(isSwitched ? status[0] : status[1]),
                    trailing: Switch(
                      value: isSwitched,
                      onChanged: (value) {
                        setState(() {
                          isSwitched = value;
                          print(isSwitched);
                        });
                      },
                      activeTrackColor: Theme.of(context).colorScheme.secondary,
                      activeColor: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const _userTextTile(
                  text: 'Info',
                ),
                _userHeightTile(
                  height: 10,
                ),
                _userListTile(
                  licon: Icons.email,
                  title: email ?? 'email',
                  color: Theme.of(context).colorScheme.secondary,
                ),
                _userHeightTile(
                  height: 10,
                ),
                _userListTile(
                  licon: Icons.person,
                  title: "ef",
                  color: Theme.of(context).colorScheme.secondary,
                ),
                _userHeightTile(
                  height: 10,
                ),
                _userListTile(
                  licon: Icons.phone,
                  title: "gg",
                  color: Theme.of(context).colorScheme.secondary,
                ),
                ElevatedButton(
                  onPressed: () {
                    authService.deleteaccount();
                  },
                  child: Text('Delete User'),
                ),
                ElevatedButton(
                  onPressed: () {
                    authService.signOut();
                    print('signed out');
                  },
                  child: Text('Logga ut'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _userListTile extends StatelessWidget {
  final IconData licon;
  final Color? color;
  final String title;
  final String? subtitle;
  final IconData? ticon;
  final VoidCallback? ticoncallback;
  final VoidCallback? ontap;
  const _userListTile({
    this.subtitle,
    this.ticon,
    this.color,
    this.ticoncallback,
    this.ontap,
    Key? key,
    required this.licon,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        tileColor: Theme.of(context).colorScheme.background,
        leading: Icon(
          licon,
          color: color,
        ),
        title: Text(title),
        subtitle: subtitle == null ? null : Text(subtitle!),
        onTap: ontap,
        trailing: IconButton(
          onPressed: ticoncallback,
          icon: Icon(ticon),
        ),
      ),
    );
  }
}

class _userHeightTile extends StatelessWidget {
  final double height;
  const _userHeightTile({
    required this.height,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
    );
  }
}

class _userTextTile extends StatelessWidget {
  final String text;
  const _userTextTile({
    required this.text,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.w700,
        decoration: TextDecoration.underline,
      ),
    );
  }
}
