import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';

import '../../repository/dog_api_fetch.dart';

part 'apifetch_event.dart';
part 'apifetch_state.dart';

class ApifetchBloc extends Bloc<ApifetchEvent, ApifetchState> {
  ApifetchBloc()
      : super(ApifetchInitial(isLoading: false, null, hasError: false)) {
    on<FetchGodDetails>((event, emit) async {
      emit(ApifetchInitial(isLoading: true, null, hasError: false));
      String imageUrl = await ApiFetch.fetchDogImage();

      if (imageUrl == "error") {
        print("error occured");
        emit(ApifetchInitial(isLoading: false, null, hasError: true));
      } else {
        emit(
          ApifetchInitial(isLoading: false, imageUrl, hasError: false),
        );
      }
    });
  }
}
