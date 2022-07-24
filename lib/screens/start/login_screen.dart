import 'package:fil_lan/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

//logga in eller skapa konto
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final _formKey = GlobalKey<FormState>(debugLabel: '_EmailFormState');
    final authService = Provider.of<AuthService>(context);
    final mq = MediaQuery.of(context);
    final logo = Image.asset(
      "assets/Fil-LAN-LOGO.png",
      height: mq.size.height / 8,
    );
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("LOGGA IN"),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        hintText: "something@example.com",
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                        hintStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Skriv din mail-adress för att fortsätta';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                  ),
                  hintText: "lösenord",
                  labelText: "Lösenord",
                  labelStyle: TextStyle(
                    color: Colors.white,
                  ),
                  hintStyle: TextStyle(
                    color: Colors.white,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Skriv ett lösenord för att fortsätta';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                MaterialButton(
                    child: Text(
                      "Glömt lösenord",
                      style: Theme.of(context)
                          .textTheme
                          .caption
                          ?.copyWith(color: Colors.black),
                    ),
                    onPressed: () {
                      showAlertDialog(context);
                    }),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                  mq.size.width / 3, 0, mq.size.width / 3, 0),
              child: ElevatedButton(
                child: Text(
                  'Logga In',
                  textAlign: TextAlign.center,
                ),
                onPressed: () async {
                  final String email = _emailController.text;
                  final String password = _passwordController.text;
                  print("jao");
                  await authService.login(
                    email,
                    password,
                    (e) => _showErrorDialog(context, 'Failed to sign in', e),
                  );
                  print("noo");
                  Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '${(e as dynamic).message}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          TextEditingController _emailControllerField = TextEditingController();
          final mq = MediaQuery.of(context);
          return AlertDialog(
            title: Text("Skriv e-mail för lösenordsåterställning:"),
            content: Container(
              width: MediaQuery.of(context).size.width / 1.2,
              height: MediaQuery.of(context).size.height / 4.5,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _emailControllerField,
                    style: Theme.of(context).textTheme.bodyText2,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                      hintText: "something@example.com",
                      labelText: "Email",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.height / 12,
                    child: TextButton(
                      onPressed: () async {
                        try {
                          FirebaseAuth.instance.sendPasswordResetEmail(
                              email: _emailControllerField.text);
                          Navigator.of(context).pop();
                        } catch (e) {
                          print(e);
                          // TODO: Add snackbar reporting error
                        }
                      },
                      child: Text("Skicka återställnings till mail"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
