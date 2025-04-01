import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:fitness_app/data/workout_data.dart';
import 'package:meta/meta.dart';

part 'workout_event.dart';
part 'workout_state.dart';

class WorkoutsBloc extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutsBloc() : super(WorkoutsInitial()) {
    on<CardTappedEvent>(_onCardTapped);
  }

  FutureOr<void> _onCardTapped(
      CardTappedEvent event, Emitter<WorkoutsState> emit) {
    emit(CardTappedState(workout: event.workout));
  }
}
