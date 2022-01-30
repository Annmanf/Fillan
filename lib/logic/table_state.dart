part of 'table_bloc.dart';

@immutable
class TableState {
  final String nameMovie;
  final String imageMovie;
  final String date;
  final String time;
  final List<String> selectedSeats;

  TableState({
    this.nameMovie = '',
    this.imageMovie = '',
    this.date = '0',
    this.time = '00',
    List<String>? selectedSeats,
  }) : this.selectedSeats = selectedSeats ?? [];

  TableState copyWith(
          {List<Tables>? seats,
          String? date,
          String? time,
          List<String>? selectedSeats,
          String? nameMovie,
          String? imageMovie}) =>
      TableState(
          nameMovie: nameMovie ?? this.nameMovie,
          imageMovie: imageMovie ?? this.imageMovie,
          date: date ?? this.date,
          time: time ?? this.time,
          selectedSeats: selectedSeats ?? this.selectedSeats);
}
