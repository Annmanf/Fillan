import 'dart:async';
import 'dart:convert';
import 'dart:ui' as ui;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/models/users.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:fil_lan/widgets/aes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileScreen extends StatefulWidget {
  static String? username = '';
  static String? phonenumber = '';
  static const routeName = '/profile-screen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  AESEncryption encryption = AESEncryption();
  bool isOkaytoDelete = false;
  bool isSwitched = false;
  bool dataLoaded = false;
  bool qrBuildDone = false;
  List<String> status = ['online', 'offline'];
  User? userData;
  Map<String, dynamic>? userDataAsMap = {};
  String encodedJson = '';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final authService = Provider.of<AuthService>(context);
    String? email = authService.email;
    Stream<DocumentSnapshot<Map<String, dynamic>>> _userstream =
        authService.getUserInfo();

    Future.delayed(const Duration(seconds: 0), () async {
      var h = await authService.getUserAsMap();
      if (!mounted) return;
      _userstream.listen((event) {
        if (event.exists) {
          setState(() {
            userData = authService.updateInfo(event.data()!);
            userDataAsMap = h;
          });
        }
      });
      dataLoaded = true;
      encodedJson = jsonEncode(userDataAsMap);
      // await for the Firebase initialization to occur
    });
    String firstandLastName = (userData?.username ?? 'username') +
        ' ' +
        (userData?.lastname ?? 'lastname');

    final qrFutureBuilder = FutureBuilder<ui.Image>(
      future: _loadOverlayImage(),
      builder: (ctx, snapshot) {
        final size = mq.width / 5;
        if (!snapshot.hasData) {
          return Container(width: size, height: size);
        }
        return CustomPaint(
          size: Size.square(size),
          painter: QrPainter(
            data: encryption.encryptMsg(encodedJson).base16 ?? '',
            version: QrVersions.auto,
            eyeStyle: const QrEyeStyle(
              eyeShape: QrEyeShape.square,
              color: FilLanTheme.blue,
            ),
            dataModuleStyle: const QrDataModuleStyle(
              dataModuleShape: QrDataModuleShape.circle,
              color: FilLanTheme.blue,
            ),
            // size: 320.0,
            embeddedImage: snapshot.data,
            embeddedImageStyle: QrEmbeddedImageStyle(
              size: Size.square(size / 6),
            ),
          ),
        );
      },
    );
    return dataLoaded
        ? CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Theme.of(context).colorScheme.background,
                pinned: true,
                stretch: true,
                expandedHeight: mq.height * 0.2,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: Row(
                    children: [
                      SizedBox(
                        width: 12,
                      ),
                      Container(
                        child: qrFutureBuilder,
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Flexible(
                        child: Text(
                          firstandLastName,
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
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
                            onChanged: (value) async {
                              await authService.setStatus(value).then((val) {
                                setState(() {
                                  isSwitched = value;
                                  print('isSwitched $isSwitched');
                                });
                              });
                            },
                            activeTrackColor:
                                Theme.of(context).colorScheme.secondary,
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
                        label: 'email',
                        title: userData?.email ?? 'email',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const _userHeightTile(
                        height: 10,
                      ),
                      _userListTile(
                        licon: Icons.person,
                        label: 'Förnamn',
                        title: userData?.username ?? 'Förnamn',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      _userHeightTile(
                        height: 10,
                      ),
                      _userListTile(
                        licon: Icons.person,
                        label: 'Efternamn',
                        title: userData?.lastname ?? 'Efternamn',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      _userHeightTile(
                        height: 10,
                      ),
                      _userListTile(
                        licon: Icons.phone,
                        label: 'phonenumber',
                        title: userData?.phonenumber ?? 'telefonnummer',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      _userHeightTile(
                        height: 10,
                      ),
                      _userListTile(
                        licon: Icons.home,
                        label: 'adress',
                        title: userData?.adress ?? 'adress',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      _userHeightTile(
                        height: 10,
                      ),
                      _userListTile(
                        licon: Icons.cake,
                        label: 'Födelsedag',
                        title: userData?.birthday ?? 'födelsefag',
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      ElevatedButton(
                        style: FilLanTheme.butDStyle,
                        onPressed: () async {
                          await authService.signOut();
                          print('Utloggas');
                        },
                        child: Text('Logga ut'),
                      ),
                      TextButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                _buildPopupDialog(context),
                          );
                          isOkaytoDelete
                              ? authService.deleteaccount()
                              : print('Får ej radera användare');
                        },
                        child: Text('Radera Konto'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
        : CircularProgressIndicator();
  }

  Future<ui.Image> _loadOverlayImage() async {
    final completer = Completer<ui.Image>();
    final byteData = await rootBundle.load('assets/ProfilVit.png');
    ui.decodeImageFromList(byteData.buffer.asUint8List(), completer.complete);
    return completer.future;
  }

  Widget _buildPopupDialog(BuildContext context) {
    return AlertDialog(
      title: const Text('Radera Konto'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const <Widget>[
          Text('Är du säker på att du vill ta bort ditt konto?'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            setState(() {
              isOkaytoDelete = false;
            });
            Navigator.of(context).pop();
          },
          child: const Text('Nej'),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              isOkaytoDelete = true;
            });
            Navigator.of(context).pop();
          },
          child: const Text('Ja'),
        ),
      ],
    );
  }

  Widget _buildQrCode() {
    Map<String, dynamic> myData;

    String encodedJson = jsonEncode(userDataAsMap);

    //return GeneratedQR(encryption.encryptMsg(encodedJson).base16);

    return QrImage(
      data: encryption.encryptMsg(encodedJson).base16,
      version: QrVersions.auto,
      size: 100.0,
      embeddedImage: AssetImage('assets/ProfilVit.png'),
      foregroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}

Widget _buildFormPopupDialog(BuildContext context, String field, String val) {
  final _authService = Provider.of<AuthService>(context);
  final TextEditingController textcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  return AlertDialog(
    title: const Text('Ändra Konto'),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        TextFormField(
          key: _formKey,
          style: const TextStyle(
            color: FilLanTheme.lightTextColor,
          ),
          controller: textcontroller,
          decoration: const InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: FilLanTheme.lightTextColor,
              ),
            ),
            labelStyle: TextStyle(
              color: FilLanTheme.lightTextColor,
            ),
            hintStyle: TextStyle(
              color: FilLanTheme.lightTextColor,
            ),
          ),
          validator: (value) {
            //if (value!.isEmpty) return 'Field is required.';
            return null;
          },
        ),
      ],
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          //add user info via service
          Navigator.of(context).pop();
        },
        child: const Text('Ångra'),
      ),
      ElevatedButton(
        onPressed: () {
          //_formKey.currentState!.save();
          _authService.editUser(field, textcontroller.text, (e) {
            print('failed to update');
          });
          _authService.getUserInfo();

          Navigator.of(context).pop();
        },
        child: const Text('Spara'),
      ),
    ],
  );
}

class _userListTile extends StatelessWidget {
  final IconData licon;
  final Color? color;
  final String title;
  final String label;
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
    required this.label,
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
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) =>
                _buildFormPopupDialog(context, label, title),
          );
        },
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
