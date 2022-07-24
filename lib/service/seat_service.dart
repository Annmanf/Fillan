import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fil_lan/models/tables.dart';

class SeatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final tablesRef =
      FirebaseFirestore.instance.collection('seats').withConverter<Tables>(
            fromFirestore: (snapshot, _) => Tables.fromJson(snapshot.data()!),
            toFirestore: (table, _) => table.toJson(),
          );

  addSelectedSeats(int tableRow, List<dynamic> free, List<String> selected) {
    tablesRef.doc('$tableRow').update({
      'freeSeats': free,
      'selectedSeats': selected,
    });
  }

  getSelectedSeats() async {
    List<String> selected = [];
    tablesRef.snapshots().forEach((table) {
      for (var item in table.docs) {
        if (item.exists) {
          selected.add(item.get('selectedSeats').toString());
        }
      }
    });
    return selected;
  }

  updateSeats() {}

  Future<void> addTablesInFirebase(
      int nrOfTables, List<dynamic> freeSeats, int nrOfSeats) async {
    for (var i = 0; i < nrOfTables; i++) {
      try {
        await _firestore.collection('seats').doc('${i + 1}').set({
          'end': false,
          'freeSeats': [1, 2, 3, 4, 5, 6, 7, 8, 9],
          'seats': nrOfSeats,
          'tableSeats': i + 1,
          'selectedSeats': [],
        }).onError((error, stackTrace) => print('failed to add data $error'));
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }
  }
}
