import 'package:flutter_bloc/flutter_bloc.dart';

part 'anmald_state.dart';

class AnmaldCubit extends Cubit<AnmaldState> {
  AnmaldCubit() : super(AnmaldState(anmald: false));

  setAnmald() {
    emit(AnmaldState(anmald: true));
  }
}
