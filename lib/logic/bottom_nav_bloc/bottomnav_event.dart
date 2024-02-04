part of 'bottomnav_bloc.dart';

class BottomnavEvent {}

class BottomNavChange extends BottomnavEvent {
  final int currentIndex;
  BottomNavChange({required this.currentIndex});
}


