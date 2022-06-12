import 'package:fil_lan/service/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

//logga in eller skapa konto
class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegExp regExp2 = RegExp(r'([0-9/])');
  RegExp regphone = RegExp(r'([0-9])');
  bool kontaktperson = false;
  final _formKey = GlobalKey<FormState>();
  var val;
  var nu;

  @override
  Widget build(BuildContext context) {
    final TextEditingController _firstnameController = TextEditingController();
    final TextEditingController _lastnameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _birthdayController = TextEditingController();
    final TextEditingController _adressController = TextEditingController();
    final TextEditingController _postalController = TextEditingController();
    final TextEditingController _phonenumberController =
        TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _konFnameController = TextEditingController();
    final TextEditingController _konLnameController = TextEditingController();
    final TextEditingController _konEmailController = TextEditingController();
    final TextEditingController _konPhoneController = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    if (value!.isEmpty) return 'Field is required.';
                    String pattern = r'\w+@\w+\.\w+';
                    if (!RegExp(pattern).hasMatch(value))
                      return 'Invalid E-mail Address format.';
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  child: MaterialButton(
                    child: Text(
                      'Skapa Konto',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) => NamePass(
                                  email: _emailController.text,
                                  kontakt: kontaktperson,
                                ));
                        Navigator.of(context).push(route);
                      }
                      return;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NamePass extends StatefulWidget {
  final String email;
  bool kontakt;
  NamePass({Key? key, required this.email, required this.kontakt})
      : super(key: key);

  @override
  State<NamePass> createState() => _NamePassState();
}

class _NamePassState extends State<NamePass> {
  final _firstnameController = TextEditingController();

  final _lastnameController = TextEditingController();

  final _birthdayController = TextEditingController();

  final _passwordController = TextEditingController();

  final _nameKey = GlobalKey<FormState>();

  RegExp regExp2 = RegExp(r'([0-9/])');

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Form(
          key: _nameKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tillbaka'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _firstnameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "förnamn",
                    labelText: "Förnamn",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Skriv ditt förnamn för att fortsätta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _lastnameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "efternamn",
                    labelText: "Efternamn",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Skriv ditt efternamn för att fortsätta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _birthdayController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "yyyymmdd",
                    labelText: "Födelsedatum",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.purpleAccent,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(8),
                    FilteringTextInputFormatter.allow(regExp2),
                    BirthdateFormatter(),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Fyll i födelsedatum';
                    }
                    return null;
                  },
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
                    hintText: "password",
                    labelText: "Password",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Enter a password to continue';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    mq.size.width / 4, 10, mq.size.width / 4, 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  child: MaterialButton(
                      minWidth: mq.size.width / 1.5,
                      child: const Text(
                        'Nästa',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {
                        if (_nameKey.currentState!.validate()) {
                          String now =
                              DateTime.now().toIso8601String().substring(0, 10);
                          now = now.replaceAll('-', '');
                          String? tmp = _birthdayController.text;
                          int val = int.parse(tmp);
                          int nu = int.parse(now);
                          bool kontakt = false;
                          if ((nu - val) < 180000) {
                            //addContacts();
                            kontakt = true;
                          }
                          print(kontakt);
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) => AdressPhone(
                                    email: widget.email,
                                    firstname: _firstnameController.text,
                                    lastname: _lastnameController.text,
                                    birthdate: _birthdayController.text,
                                    password: _passwordController.text,
                                    kontakt: kontakt,
                                  ));
                          Navigator.of(context).push(route);
                        }
                      }

                      /*


                        final String firstname = _firstnameController.text;
                        final String lastname = _lastnameController.text;
                        final String email = _emailController.text;
                        final String birthdate = _birthdayController.text;
                        final String adress = _adressController.text;
                        final String phonenumber = _phonenumberController.text;
                        final String password = _passwordController.text;

                        authService.signUp(
                          firstname,
                          lastname,
                          email,
                          birthdate,
                          adress,
                          phonenumber,
                          password,
                          (e) => _showErrorDialog(
                              context, 'Failed to register', e),
                        );

                    authService.addUser(
                      name,
                      email,
                      password,
                      (e) => _showErrorDialog(context, 'Failed to add user', e),
                    );*/

                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AdressPhone extends StatefulWidget {
  final String email;
  final String firstname;
  final String lastname;
  final String birthdate;
  final String password;
  bool kontakt;
  AdressPhone({
    Key? key,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.birthdate,
    required this.password,
    required this.kontakt,
  }) : super(key: key);

  @override
  State<AdressPhone> createState() => _AdressPhoneState();
}

class _AdressPhoneState extends State<AdressPhone> {
  final TextEditingController _adressController = TextEditingController();

  final TextEditingController _phonenumberController = TextEditingController();

  RegExp regExp2 = RegExp(r'([0-9/])');

  RegExp regphone = RegExp(r'([0-9])');
  final _addkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Form(
          key: _addkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tillbaka'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _adressController,
                  keyboardType: TextInputType.streetAddress,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "adress",
                    labelText: "Adress",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    } else if (regExp2.hasMatch(value)) {
                      return "input more.";
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _phonenumberController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "07xxxxxxxxxx",
                    labelText: "Telefonnummer",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(regphone),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Skriv ditt telefonnummer för att fortsätta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    mq.size.width / 4, 10, mq.size.width / 4, 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  child: MaterialButton(
                    minWidth: mq.size.width / 1.5,
                    child: const Text(
                      'Nästa',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (_addkey.currentState!.validate()) {
                        if (widget.kontakt) {
                          var route = MaterialPageRoute(
                              builder: (BuildContext context) => KontaktPerson(
                                    email: widget.email,
                                    firstname: widget.firstname,
                                    lastname: widget.lastname,
                                    birthdate: widget.birthdate,
                                    adress: _adressController.text,
                                    phonenumber: _phonenumberController.text,
                                    password: widget.password,
                                  ));
                          Navigator.of(context).push(route);
                        } else {
                          print(widget.kontakt);
                          final String firstname = widget.firstname;
                          final String lastname = widget.lastname;
                          final String email = widget.email;
                          final String birthdate = widget.birthdate;
                          final String adress = _adressController.text;
                          final String phonenumber =
                              _phonenumberController.text;
                          final String password = widget.password;

                          await authService.signUp(
                            firstname,
                            lastname,
                            email,
                            birthdate,
                            adress,
                            phonenumber,
                            password,
                            (e) => _showErrorDialog(
                                context, 'Failed to register', e),
                          );
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                        }
                      }
                      /*


                        

                    authService.addUser(
                      name,
                      email,
                      password,
                      (e) => _showErrorDialog(context, 'Failed to add user', e),
                    );*/
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class KontaktPerson extends StatefulWidget {
  final String email;
  final String firstname;
  final String lastname;
  final String birthdate;
  final String adress;
  final String phonenumber;
  final String password;

  KontaktPerson({
    Key? key,
    required this.email,
    required this.firstname,
    required this.lastname,
    required this.birthdate,
    required this.adress,
    required this.phonenumber,
    required this.password,
  }) : super(key: key);

  @override
  _KontaktPersonState createState() => _KontaktPersonState();
}

class _KontaktPersonState extends State<KontaktPerson> {
  TextEditingController _konFnameController = TextEditingController();
  TextEditingController _konLnameController = TextEditingController();
  TextEditingController _konEmailController = TextEditingController();
  TextEditingController _konPhoneController = TextEditingController();
  final GlobalKey<FormState> _konKey = GlobalKey<FormState>();

  RegExp regExp2 = RegExp(r'([0-9/])');

  RegExp regphone = RegExp(r'([0-9])');

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final mq = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Form(
          key: _konKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Tillbaka'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _konFnameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "förnamn",
                    labelText: "Kontaktperson: Förnamn",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Skriv ditt förnamn för att fortsätta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _konLnameController,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "efternamn",
                    labelText: "Kontaktperson: Efternamn",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Skriv ditt efternamn för att fortsätta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _konEmailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "something@example.com",
                    labelText: "Kontaktperson: Email",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                    errorStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.redAccent),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) return 'Field is required.';
                    String pattern = r'\w+@\w+\.\w+';
                    if (!RegExp(pattern).hasMatch(value))
                      return 'Invalid E-mail Address format.';
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: TextFormField(
                  controller: _konPhoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                    hintText: "07xxxxxxxxxx",
                    labelText: "Telefonnummer",
                    labelStyle: TextStyle(
                      color: Colors.white,
                    ),
                    hintStyle: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(regphone),
                  ],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Skriv ditt telefonnummer för att fortsätta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    mq.size.width / 4, 10, mq.size.width / 4, 10),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(25.0),
                  color: Colors.white,
                  child: MaterialButton(
                    minWidth: mq.size.width / 1.5,
                    child: const Text(
                      'Skapa Konto',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () async {
                      if (_konKey.currentState?.validate() == null) {
                        final String firstname = widget.firstname;
                        final String lastname = widget.lastname;
                        final String email = widget.email;
                        final String birthdate = widget.birthdate;
                        final String adress = widget.adress;
                        final String phonenumber = widget.phonenumber;
                        final String contactfirstname =
                            _konFnameController.text;
                        final String contactlastname = _konLnameController.text;
                        final String contactphone = _konPhoneController.text;
                        final String contactemail = _konEmailController.text;
                        final String password = widget.password;

                        await authService.signUpWithContacts(
                          firstname,
                          lastname,
                          email,
                          birthdate,
                          adress,
                          phonenumber,
                          contactfirstname,
                          contactlastname,
                          contactphone,
                          contactemail,
                          password,
                          (e) => _showErrorDialog(
                              context, 'Failed to register', e),
                        );
                      }
                      Navigator.popUntil(context,
                          ModalRoute.withName(Navigator.defaultRouteName));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
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

class BirthdateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    int selectionIndex;

    // Get the previous and current input strings
    String oText = oldValue.text;
    String nText = newValue.text;
    // Abbreviate lengths
    int oLen = oText.length;
    int nLen = nText.length;
    if (nLen == 1) {
      // Can only be 1 or 2
      int y1 = int.parse(nText.substring(0, 1));
      if (y1 < 1 || y1 > 2) {
        // Remove char
        nText = '';
      }
    } else if (nLen == 2) {
      // Can only be 19 or 20
      int y2 = int.parse(nText.substring(0, nLen));
      if (y2 < 19 || y2 > 20) {
        // Remove char
        nText = nText.substring(0, nLen - 1);
      }
    } else if (nLen == 4 && oLen == 3) {
      // Can only be 1 or 2 - if so insert a / char
      int y1 = int.parse(nText.substring(0, nLen));
      if (y1 < 1900 || y1 > DateTime.now().year) {
        // Replace char
        nText = nText.substring(0, oLen);
      }
    } else if (nLen == 5 && oLen == 4) {
      if (int.parse(nText.substring(oLen, nLen)) > 1) {
        // Replace char
        nText = nText.substring(0, oLen);
      } else {
        // Insert / char
        nText = nText.substring(0, oLen + 1);
      }
    } else if (nLen == 6 && oLen == 5) {
      // Month cannot be greater than 12
      int mm = int.parse(nText.substring(nLen - 2, nLen));
      if (mm == 0 || mm > 12) {
        // Remove char
        nText = nText.substring(0, oLen);
      }
    } else if (nLen == 7) {
      // Can only be 0, 1, 2 or 3
      if (int.parse(nText.substring(nLen - 1, nLen)) > 3) {
        // Remove char
        nText = nText.substring(0, nLen - 1);
      }
    } else if (nLen == 8 && oLen == 7) {
      // Days cannot be greater than 31
      int dd = int.parse(nText.substring(nLen - 2, nLen));
      if (dd == 0 || dd > 31) {
        // Remove char
        nText = nText.substring(0, oLen);
      } else {
        // Add a / char
        nText = nText.substring(0, nLen);
      }
    }

    selectionIndex = nText.length;
    return TextEditingValue(
      text: nText,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
