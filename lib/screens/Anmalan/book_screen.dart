import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/models/tables.dart';
import 'package:fil_lan/screens/Anmalan/paint_seats.dart';
import 'package:fil_lan/service/auth_services.dart';
import 'package:fil_lan/service/seat_service.dart';
import 'package:fil_lan/theme/fil_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookSeats extends StatefulWidget {
  //final List<Tables> allSeats;
  const BookSeats({Key? key}) : super(key: key);

  @override
  State<BookSeats> createState() => _BookSeatsState();
}

class _BookSeatsState extends State<BookSeats> {
  List<Tables> allSeats = [];
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Stream<QuerySnapshot> _tablesStream =
      FirebaseFirestore.instance.collection('seats').snapshots();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final seatService = Provider.of<SeatService>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          SizedBox(height: 100.0),
          Container(
            height: 500,
            width: size.width,
            child: StreamBuilder<QuerySnapshot>(
              stream: _tablesStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;

                    //print(
                    // 'seats: ${data['seats']} freeSeats: ${data['freeSeats']} tableSeats: ${data['tableSeats']}');
                    return SeatsRow(
                      numSeats: data['seats'],
                      freeSeats: data['freeSeats'],
                      tableSeats: data['tableSeats'],
                      selSeats: "11",
                    );
                  }).toList(),
                );

                /*
                return ListView(
                  children: List.generate(
                    widget.allSeats.last.tableSeats - 1,
                    (i) => SeatsRow(
                      numSeats: widget.allSeats[i].seats,
                      freeSeats: widget.allSeats[i].freeSeats,
                      tableSeats: widget.allSeats[i].tableSeats,
                      selSeats: "",
                    ),
                  ),
                );
                ListTile(
                      title: Text(data['full_name']),
                      subtitle: Text(data['company']),
                    );
                */
              },
            ),
          ),
          TextButton(
            style: FilLanTheme.butBStyle,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Välj",
              style: FilLanTheme.sdTextStyle,
            ),
          )
        ],
      ),
    );
  }

  Future<int> getlength() async {
    return await _firestore.collection('seats').snapshots().length;
  }

  Future<Tables> getTable(int tablenr) async {
    late Tables tables;
    await _firestore.collection('seats').doc('$tablenr').get().then((value) {
      if (value.exists) {
        Map<String, dynamic> data = value.data() as Map<String, dynamic>;
        Tables table = Tables.fromJson(data);
        tables = table;
      }
    });
    return tables;
  }

  Future<List<Tables>> getTables() async {
    List<Tables> tables = [];
    await _firestore.collection('seats').snapshots().forEach((element) {
      element.docs.forEach((item) {
        if (item.exists) {
          Map<String, dynamic> data = item.data();
          Tables table = Tables.fromJson(data);
          if (!tables.contains(table)) {
            tables.add(table);
          }
        }
      });
    });
    print('tables $tables');
    return tables;
  }

  Future<List<dynamic>> getFreeSeats(int tablenr) async {
    return await getTable(tablenr).then((value) => value.freeSeats);
  }

  Future<int> getNrSeats(int tablenr) async {
    return await getTables().then((value) => value[tablenr].seats);
  }

  Future<int> getTableNr(int tablenr) async {
    return await getTables().then((value) => value[tablenr].tableSeats);
  }
}
