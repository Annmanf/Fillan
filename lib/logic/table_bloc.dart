import 'package:fil_lan/models/tables.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvenet, TableState> {
  TableBloc() : super(TableState()) {
    on<OnSelectedSeatsEvent>(_onSelectedSeats);
  }

  List<String> seats = [];

  Future<void> _onSelectedDate(
      OnSelectedDateEvent event, Emitter<TableState> emit) async {
    emit(state.copyWith(date: event.date));
  }

  Future<void> _onSelectedTime(
      OnSelectedTimeEvent event, Emitter<TableState> emit) async {
    emit(state.copyWith(time: event.time));
  }

  Future<void> _onSelectedSeats(
      OnSelectedSeatsEvent event, Emitter<TableState> emit) async {
    if (seats.contains(event.selectedSeats)) {
      seats.remove(event.selectedSeats);
      emit(state.copyWith(selectedSeats: seats));
    } else if (seats.isNotEmpty) {
      seats.remove(event.selectedSeats);
      //print('full');
    } else {
      seats.add(event.selectedSeats);
      emit(state.copyWith(selectedSeats: seats));
    }
  }

  String getSelectedSeat() {
    return seats[0];
  }

  Future<void> _onSelectedMovie(
      OnSelectMovieEvent event, Emitter<TableState> emit) async {
    emit(state.copyWith(nameMovie: event.name, imageMovie: event.image));
  }
}
