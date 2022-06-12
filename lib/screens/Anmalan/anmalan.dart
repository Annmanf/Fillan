import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/models/tables.dart';
import 'package:fil_lan/screens/Anmalan/checkbox_state.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Anmalan extends StatefulWidget {
  final seats;
  Anmalan({Key? key, required this.seats}) : super(key: key);

  @override
  State<Anmalan> createState() => _AnmalanState();
}

class _AnmalanState extends State<Anmalan> {
  Map<String, String> fieldValues = {};
  setFieldValue(label, value) {
    fieldValues[label] = value;
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final size = MediaQuery.of(context).size;
    final tableBloc = BlocProvider.of<TableBloc>(context);

    final authService = Provider.of<AuthService>(context);
    final TextEditingController textcontroller = TextEditingController();

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 55,
                ),
                RegisterFormBox(
                  color: Colors.grey.shade800,
                  callback: setFieldValue,
                  question: 'Kommer du spela datorspel eller tv-spel primärt?',
                  label: 'spel',
                  alt1: 'Dator',
                  alt2: 'TV',
                  radio: true,
                ),
                RegisterFormBox(
                  color: Colors.grey.shade800,
                  callback: setFieldValue,
                  question:
                      'Vill du ha mat? (Frukost och lunch) Kostar ${Fil_LanTheme.food} tillägg',
                  label: 'mat',
                  alt1: 'Ja',
                  alt2: 'Nej',
                  radio: true,
                ),
                RegisterFormBox(
                  color: Colors.grey.shade800,
                  callback: setFieldValue,
                  question: 'Vilka turneringar är du intresserad av?',
                  info:
                      '(Detta är inte en anmälan, det här är endast en intresseanmälan. Vi prioriterar att arrangera de turneringar som får flest röster.)',
                  label: 'turneringar',
                  turneringar: const [
                    'LoL',
                    'FIFA',
                    'JO',
                    'crach',
                    'lock',
                    'anna',
                    'hej'
                  ],
                  radio: false,
                ),
                RegisterFormBox(
                  color: Colors.grey.shade800,
                  callback: setFieldValue,
                  question: 'Önskar du sovplats?',
                  info: '(Gäller endast för de som inte bor på öarna.)',
                  label: 'sovplats',
                  alt1: 'Ja',
                  alt2: 'Nej',
                  radio: true,
                ),
                Container(
                  margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade800,
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                        style: const TextStyle(
                          color: Fil_LanTheme.lightTextColor,
                        ),
                        controller: textcontroller,
                        decoration: const InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Fil_LanTheme.lightTextColor,
                            ),
                          ),
                          hintText: "fri text...",
                          labelText: "Något du vill säga?",
                          labelStyle: TextStyle(
                            color: Fil_LanTheme.lightTextColor,
                          ),
                          hintStyle: TextStyle(
                            color: Fil_LanTheme.lightTextColor,
                          ),
                        ),
                        validator: (value) {
                          //if (value!.isEmpty) return 'Field is required.';

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                RegisterFormBox(
                  color: Colors.grey.shade800,
                  callback: setFieldValue,
                  question:
                      'Jag är okej med att vara med på bilder och filmer som kan läggas ut på sociala medier.',
                  label: 'gdpr',
                  alt1: 'Ja',
                  radio: true,
                ),
                RegisterFormBox(
                  color: Colors.grey.shade800,
                  callback: setFieldValue,
                  question: 'Jag har läst och godkänner reglerna?',
                  label: 'regler',
                  alt1: 'Ja',
                  radio: true,
                ),
                Container(
                  height: 100,
                  child: InkWell(
                    onTap: () {
                      // ADD TO BLOC
                      //tableBloc.add(OnSelectMovieEvent('endgame', 'sol.jpg'));

                      Navigator.of(context).pushNamed('/book_screen');
                    },
                    child: const Text(
                      'Book Seat',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Fil_LanTheme.lightTextColor),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
                  child: ElevatedButton(
                    style: Fil_LanTheme.butPStyle,
                    child: const Text(
                      'Fortsätt till betalning',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        String res = tableBloc.getSelectedSeat();

                        String b = res.substring(0, 1);
                        int h = int.parse(res.substring(0, 1));

                        int l = int.parse(res.substring(1, 2));
                        //List<Tables> seat = globals.seats as List<Tables>;

                        List<Tables> seat = [];
                        for (var item in widget.seats) {
                          seat.add(item);
                        }
                        //seat[h - 1].freeSeats.remove(l);

                        //List<dynamic> newFree = seat[h - 1].freeSeats;
                        // seatService.chooseSeat(b, newFree);

                        _formKey.currentState!.save();
                        /*
                        var route = MaterialPageRoute(
                            builder: (BuildContext context) => PaymentScreen(
                                  cost: fieldValues['mat'] == 'Ja'
                                      ? Fil_LanTheme.cost + Fil_LanTheme.food
                                      : Fil_LanTheme.cost,
                                ));
                        Navigator.of(context).push(route);*/
/*
                        authService.addAnmalan(
                            fieldValues['spel']!,
                            fieldValues['mat']!,
                            fieldValues['turneringar']!,
                            fieldValues['sovplats']!,
                            textcontroller.text,
                            fieldValues['gdpr']!,
                            fieldValues['regler']!,
                            'no seat yet');
                        //,'${tableBloc.state.selectedSeats[0]} ');

                        Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName));*/
                      }
                      return;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RegisterFormBox extends StatefulWidget {
  final Color color;
  final Function callback;
  final String question;
  final String label;
  final String? alt1;
  final String? alt2;
  final List<String>? turneringar;
  final bool radio;
  final String? info;
  const RegisterFormBox(
      {Key? key,
      required this.color,
      required this.callback,
      required this.question,
      required this.label,
      required this.radio,
      this.alt1,
      this.alt2,
      this.turneringar,
      this.info})
      : super(key: key);

  @override
  _RegisterFormBoxState createState() => _RegisterFormBoxState();
}

class _RegisterFormBoxState extends State<RegisterFormBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 25, 20, 0),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: widget.color,
      ),
      child: Column(
        children: [
          Text(
            widget.question,
            style: Fil_LanTheme.slTextStyle,
          ),
          widget.info != null
              ? Text(
                  widget.info!,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                )
              : Column(),
          widget.radio
              ? RadioFormField(
                  callback: widget.callback,
                  label: widget.label,
                  alt1: widget.alt1!,
                  alt2: widget.alt2)
              : SafeArea(
                  child: Container(
                    height: 100,
                    padding: const EdgeInsets.fromLTRB(50, 0, 50, 0),
                    child: CheckboxFormField(
                        callback: widget.callback,
                        label: widget.label,
                        turneringar: widget.turneringar!),
                  ),
                ),
        ],
      ),
    );
  }
}

class RadioFormField extends StatefulWidget {
  final Function callback;
  final String label;
  final String alt1;
  final String? alt2;
  const RadioFormField(
      {Key? key,
      required this.callback,
      required this.label,
      required this.alt1,
      this.alt2})
      : super(key: key);

  @override
  _RadioFormFieldState createState() => _RadioFormFieldState();
}

class _RadioFormFieldState extends State<RadioFormField> {
  String radioValue = '';
  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.alt1,
                  style: TextStyle(color: Colors.white70),
                ),
                Radio<String>(
                  activeColor: Fil_LanTheme.blue,
                  value: widget.alt1,
                  groupValue: radioValue,
                  onChanged: (value) => setState(() => radioValue = value!),
                ),
              ],
            ),
            Visibility(
              visible: (widget.alt2 != null) ? true : false,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.alt2 ?? '',
                    style: TextStyle(color: Colors.white70),
                  ),
                  Radio<String>(
                    activeColor: Fil_LanTheme.blue,
                    value: widget.alt2 ?? '',
                    groupValue: radioValue,
                    onChanged: (value) => setState(() => radioValue = value!),
                  ),
                ],
              ),
            ),
            Text(
              state.errorText ?? '',
              style: TextStyle(color: Theme.of(context).errorColor),
            )
          ],
        );
      },
      validator: (value) {
        if (radioValue == '') {
          return 'You must choose something';
        }
        return null;
      },
      onSaved: (newValue) =>
          widget.callback(widget.label, radioValue.toString()),
    );
  }
}

class CheckboxFormField extends StatefulWidget {
  final Function callback;
  final String label;
  final List<String> turneringar;
  const CheckboxFormField(
      {Key? key,
      required this.callback,
      required this.label,
      required this.turneringar})
      : super(key: key);

  @override
  _CheckboxFormFieldState createState() => _CheckboxFormFieldState();
}

class _CheckboxFormFieldState extends State<CheckboxFormField> {
  bool checkboxValue = false;
  //final turnering = [CheckBoxState(title: 'Lol'), CheckBoxState(title: 'Fifa')];
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  Map<String, bool> list = {
    'LoL': false,
    'FIFA': false,
  };
  var holder_1 = [];

  getItems() {
    list.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print('holder_1 $holder_1');
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FormField(
      builder: (state) {
        return Column(
          children: [
            Expanded(
              child: ListView(
                children: list.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: list[key],
                    activeColor: Fil_LanTheme.pink,
                    checkColor: Fil_LanTheme.darkTextColor,
                    tileColor: Fil_LanTheme.lightTextColor,
                    onChanged: (bool? value) {
                      setState(() {
                        list[key] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ),
            /*
            for (CheckBoxState checkbox in turnering)
              CheckboxListTile(
                  title: Text(
                    checkbox.title,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  value: checkbox.value,
                  onChanged: (value) {
                    setState(() {
                      checkboxValue = value!;
                    });
                  }),

            
            ListView(
              children: values.keys.map((String key) {
                return CheckboxListTile(
                  title: Text(key),
                  value: values[key],
                  onChanged: (value) {
                    setState(() {
                      values[key] = value;
                    });
                  },
                );
              }).toList(),
            ),
            Row(
              children: [
                Text(
                  widget.turneringar[0],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Checkbox(
                    value: checkboxValue,
                    onChanged: (value) {
                      setState(() {
                        checkboxValue = value!;
                        state.didChange(value);
                      });
                    }),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.turneringar[1],
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Checkbox(
                    value: checkboxValue,
                    onChanged: (value) {
                      setState(() {
                        checkboxValue = value!;
                        state.didChange(value);
                      });
                    }),
              ],
            ),*/
            Text(
              state.errorText ?? '',
              style: TextStyle(color: Theme.of(context).errorColor),
            )
          ],
        );
      },
      validator: (value) => checkboxValue ? 'you must check' : null,
      onSaved: (newValue) => widget.callback(widget.label, newValue.toString()),
    );
  }

  Widget buildSingleCheckbox(CheckBoxState checkbox) => CheckboxListTile(
      value: checkbox.value,
      onChanged: (value) => setState(() {
            checkboxValue = value!;
          }));
}
