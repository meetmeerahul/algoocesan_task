import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnav_event.dart';
part 'bottomnav_state.dart';

class BottomnavBloc extends Bloc<BottomnavEvent, BottomnavState> {
  BottomnavBloc() : super(const BottomnavInitial(currentIndex: 0)) {
    on<BottomNavChange>((event, emit) {
      emit(BottomnavInitial(currentIndex: event.currentIndex));
    });
  }
}
