part of 'history_bloc.dart';

class HistoryBlocState {
  final bool isLoading;

  final List<String>? dogList;

  HistoryBlocState(this.dogList, {required this.isLoading});
}

class HistoryblocInitial extends HistoryBlocState {
  HistoryblocInitial(super.dogList, {required super.isLoading});
}
