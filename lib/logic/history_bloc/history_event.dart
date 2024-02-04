part of 'history_bloc.dart';

@immutable
sealed class HistoryBlocEvent {}

class GetHistory extends HistoryBlocEvent {}

class DeleteHistory extends HistoryBlocEvent {
  final int index;

  DeleteHistory({required this.index});
}
