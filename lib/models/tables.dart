import 'package:flutter/material.dart';

class Tables {
  final int tableSeats;
  final int seats;
  final List<dynamic> freeSeats;
  final bool end;

  Tables(
      {required this.tableSeats,
      required this.seats,
      required this.freeSeats,
      required this.end});

  factory Tables.fromJson(Map<String, dynamic> json) {
    return Tables(
        tableSeats: json['tableSeats'],
        seats: json['seats'],
        freeSeats: json['freeSeats'],
        end: json['end']);
  }

  static List<Tables> listchairs = [
    Tables(
        tableSeats: 1,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 2,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 3,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 4,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 5,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 6,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 7,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 8,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 9,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 10,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 11,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 12,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 13,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 14,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 15,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 16,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
    Tables(
        tableSeats: 17,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: false),
    Tables(
        tableSeats: 18,
        seats: 9,
        freeSeats: [1, 2, 3, 4, 5, 6, 7, 8, 9],
        end: true),
  ];

  void addTables(int b, List<int> a) {
    List<Tables>? chairs;
    List<int>? free;
    for (var i = 1; i == 18; i++) {
      chairs!.add(
        Tables(
            tableSeats: i,
            seats: 9,
            freeSeats: i == b ? a : [1, 2, 3, 4, 5, 6, 7, 8, 9],
            end: end),
      );
    }
  }
}
