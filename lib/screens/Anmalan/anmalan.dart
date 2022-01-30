import 'package:fil_lan/logic/table_bloc.dart';
import 'package:fil_lan/models/tables.dart';
import 'package:fil_lan/screens/Anmalan/checkbox_state.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/service/seat_firebase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class Anmalan extends StatefulWidget {
  var seats;
  Anmalan({Key? key, this.seats}) : super(key: key);

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
    SeatFire seatService = Provider.of<SeatFire>(context, listen: false);
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
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 70, 20, 0),
                  child: Text(
                    'Kommer du spela datorspel eller tv-spel primärt?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: RadioFormField(
                      callback: setFieldValue,
                      label: 'spel',
                      alt1: 'Dator',
                      alt2: 'TV'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    'Vill du ha mat? (Frukost och lunch) Kostar ... tillägg',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: RadioFormField(
                    callback: setFieldValue,
                    label: 'mat',
                    alt1: 'Ja',
                    alt2: 'Nej',
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        'Vilka turneringar är du intresserad av?',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '(Detta är inte en anmälan, det här är endast en intresseanmälan. Vi prioriterar att arrangera de turneringar som får flest röster.)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                SafeArea(
                  child: Container(
                    height: 100,
                    padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                    child: CheckboxFormField(
                        callback: setFieldValue,
                        label: 'turneringar',
                        turneringar: ['LoL', 'FIFA']),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        'Önskar du sovplats? ()',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        '(Gäller endast för de som inte bor på öarna.)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: RadioFormField(
                    callback: setFieldValue,
                    label: 'sovplats',
                    alt1: 'Ja',
                    alt2: 'Nej',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: TextFormField(
                    controller: textcontroller,
                    decoration: const InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                      ),
                      hintText: "free text...",
                      labelText: "Anything you want to say?",
                      labelStyle: TextStyle(
                        color: Colors.white,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) return 'Field is required.';

                      return null;
                    },
                  ),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    'Jag är okej med att vara med på bilder och filmer som kan läggas ut på sociala medier.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: RadioFormField(
                    callback: setFieldValue,
                    label: 'gdpr',
                    alt1: 'Ja',
                  ),
                ),
                Container(
                  height: 70,
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                  child: Text(
                    'Jag har läst och godkänner reglerna?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  padding: EdgeInsets.fromLTRB(70, 20, 70, 0),
                  child: RadioFormField(
                    callback: setFieldValue,
                    label: 'regler',
                    alt1: 'Ja',
                  ),
                ),
                Container(
                  height: 100,
                  child: InkWell(
                    onTap: () {
                      // ADD TO BLOC
                      //tableBloc.add(OnSelectMovieEvent('endgame', 'sol.jpg'));

                      Navigator.of(context).pushNamed('/book_screen');
                    },
                    child: Text(
                      'Book Seat',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                        'Anmäl',
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
                          print(res);
                          String b = res.substring(0, 1);
                          int h = int.parse(res.substring(0, 1));

                          int l = int.parse(res.substring(1, 2));
                          //List<Tables> seat = globals.seats as List<Tables>;
                          print(b);
                          print(h);
                          print(l);

                          List<Tables> seat = [];
                          for (var item in widget.seats) {
                            seat.add(item);
                          }
                          seat[h - 1].freeSeats.remove(l);

                          //seats[h].freeSeats.remove(l);
                          print(widget.seats[h - 1]);
                          print(seat[h - 1].freeSeats);

                          List<dynamic> newFree = seat[h - 1].freeSeats;
                          seatService.chooseSeat(b, newFree);
                          _formKey.currentState!.save();
                          authService.addAnmalan(
                              fieldValues['spel']!,
                              fieldValues['mat']!,
                              fieldValues['turneringar']!,
                              fieldValues['sovplats']!,
                              textcontroller.text,
                              fieldValues['gdpr']!,
                              fieldValues['regler']!,
                              '${tableBloc.state.selectedSeats[0]} ');
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
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
              children: [
                Text(
                  widget.alt1,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Radio<String>(
                  value: widget.alt1,
                  groupValue: radioValue,
                  onChanged: (value) => setState(() => radioValue = value!),
                ),
              ],
            ),
            Visibility(
              visible: (widget.alt2 != null) ? true : false,
              child: Row(
                children: [
                  Text(
                    widget.alt2 ?? '',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  Radio<String>(
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
  final turnering = [CheckBoxState(title: 'Lol'), CheckBoxState(title: 'Fifa')];
  Map<String, bool> values = {
    'foo': true,
    'bar': false,
  };
  Map<String, bool> List = {
    'LoL': false,
    'FIFA': false,
  };
  var holder_1 = [];

  getItems() {
    List.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
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
                children: List.keys.map((String key) {
                  return CheckboxListTile(
                    title: Text(key),
                    value: List[key],
                    activeColor: Colors.deepPurple[400],
                    checkColor: Colors.white,
                    onChanged: (bool? value) {
                      setState(() {
                        List[key] = value!;
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
