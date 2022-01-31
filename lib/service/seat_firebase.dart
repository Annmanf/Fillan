import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/models/tables.dart';

class SeatFire {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final List<Tables> _tables = [];

  List<Tables> getTables() {
    return _tables;
  }

  Future<void> chooseSeat(String row, List<dynamic> free) async {
    return _firestore
        .collection('seats')
        .doc(row)
        .update({'freeSeats': free})
        .then((value) => print('updated seat'))
        .catchError((error) => print("Failed to update seat: $error"));
  }

  Future<void> getSeatsFromFirebas(
      void Function(FirebaseException e) errorCallback) async {
    CollectionReference seatsfromfire = _firestore.collection('seats');
    try {
      seatsfromfire.snapshots().forEach((element) async {
        for (var item in element.docs) {
          print(item.id);
          DocumentSnapshot snapshot = await seatsfromfire
              .doc(item.id)
              .get()
              .catchError((onError) => print('failed'));
          print(snapshot.data());
          if (snapshot.exists) {
            //print(snapshot);
            Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;

            Tables table = Tables.fromJson(data);
            print(table.end);
            if (_tables.contains(table)) {
              print('already fetched');
            } else {
              _tables.add(table);
            }
          } else {
            print('nopoe');
          }
        }
      });
    } on FirebaseException catch (e) {
      errorCallback(e);
    }
  }
}
