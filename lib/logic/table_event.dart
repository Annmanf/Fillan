part of 'table_bloc.dart';

@immutable
abstract class TableEvenet {}

class OnSelectMovieEvent extends TableEvenet {
  final String name;
  final String image;

  OnSelectMovieEvent(this.name, this.image);
}

class OnSelectedDateEvent extends TableEvenet {
  final String date;

  OnSelectedDateEvent(this.date);
}

class OnSelectedTimeEvent extends TableEvenet {
  final String time;

  OnSelectedTimeEvent(this.time);
}

class OnSelectedSeatsEvent extends TableEvenet {
  final String selectedSeats;

  OnSelectedSeatsEvent(this.selectedSeats);
}
