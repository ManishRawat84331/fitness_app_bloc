import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:fitness_app/data/exercise_data.dart';
import 'package:fitness_app/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workoutdetails_event.dart';
part 'workoutdetails_state.dart';

class WorkoutDetailsBloc extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  final WorkoutData workout;
  
  WorkoutDetailsBloc({required this.workout}) : super(WorkoutDetailsInitial()) {
    on<BackTappedEvent>((event, emit) => emit(BackTappedState()));
    on<WorkoutExerciseCellTappedEvent>(_onWorkoutExerciseCellTapped);
  }

  void _onWorkoutExerciseCellTapped(
      WorkoutExerciseCellTappedEvent event, Emitter<WorkoutDetailsState> emit) {
    emit(WorkoutExerciseCellTappedState(
      currentExercise: event.currentExercise,
      nextExercise: event.nextExercise,
    ));
  }
}
