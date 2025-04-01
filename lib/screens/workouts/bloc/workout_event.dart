part of 'workout_bloc.dart';




abstract class WorkoutsEvent {}

class CardTappedEvent extends WorkoutsEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}
