import 'package:bloc/bloc.dart';

import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import '../../models/dog_model.dart';

part 'history_event.dart';
part 'history_state.dart';

class HistoryBloc extends Bloc<HistoryBlocEvent, HistoryBlocState> {
  HistoryBloc() : super(HistoryblocInitial(isLoading: false, [])) {
    on<HistoryBlocEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetHistory>((event, emit) async {
      emit(HistoryblocInitial([], isLoading: true));

      List<String> dogList = await fetchDogList();

      print(dogList);

      emit(HistoryblocInitial(dogList, isLoading: false));
    });
    on<DeleteHistory>((event, emit) async {
      await deleteHistory(event.index);
      print(event.index);

      List<String> dogList = await fetchDogList();
      emit(HistoryblocInitial(dogList, isLoading: false));
    });
  }

  fetchDogList() async {
    var box = await Hive.openBox<DogModel>('dogbox');
    List<String> result = [];

    var dogs = box.values.toList();

    for (var dog in dogs) {
      result.add(dog.imageUrl);
    }
    return result;
  }

  deleteHistory(int index) async {
    var box = await Hive.openBox<DogModel>('dogbox');
    box.deleteAt(index);
  }
}
