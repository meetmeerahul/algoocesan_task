part of 'bottomnav_bloc.dart';

@immutable
sealed class BottomnavState {
  final int currentIndex;

  const BottomnavState({required this.currentIndex});
}

final class BottomnavInitial extends BottomnavState {
  const BottomnavInitial({required super.currentIndex});
}

