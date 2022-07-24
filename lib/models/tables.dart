import 'package:flutter/material.dart';

class Tables {
  final int tableSeats;
  final int seats;
  final List<dynamic> freeSeats;
  final List<dynamic> selectedSeats;
  Tables(
      {required this.tableSeats,
      required this.seats,
      required this.freeSeats,
      required this.selectedSeats});
  Tables.fromJson(Map<String, Object?> json)
      : this(
            tableSeats: json['tableSeats']! as int,
            seats: json['seats']! as int,
            freeSeats: json['freeSeats']! as List<dynamic>,
            selectedSeats: json['selectedSeats']! as List<dynamic>);

  Map<String, Object?> toJson() {
    return {
      'tableSeats': tableSeats,
      'seats': seats,
      'freeSeats': freeSeats,
      'selectedSeats': selectedSeats,
    };
  }
}
