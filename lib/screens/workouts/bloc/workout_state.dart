part of 'workout_bloc.dart';



abstract class WorkoutsState {}

class WorkoutsInitial extends WorkoutsState {}

class CardTappedState extends WorkoutsState {
  final WorkoutData workout;

  CardTappedState({required this.workout});
}
