import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'start_workout_event.dart';
part 'start_workout_state.dart';

class StartWorkoutBloc extends Bloc<StartWorkoutEvent, StartWorkoutState> {
  StartWorkoutBloc() : super(StartWorkoutInitial()) {
    on<BackTappedEvent>((event, emit) => emit(BackTappedState()));
    on<PlayTappedEvent>(_onPlayTapped);
    on<PauseTappedEvent>(_onPauseTapped);
  }

  int time = 0;
  Timer? _timer;

  void _onPlayTapped(PlayTappedEvent event, Emitter<StartWorkoutState> emit) {
    time = event.time;
    _startTimer(emit);
    emit(PlayTimerState(time: time));
  }

  void _onPauseTapped(PauseTappedEvent event, Emitter<StartWorkoutState> emit) {
    _pauseTimer();
    emit(PauseTimerState(currentTime: time));
  }

  void _startTimer(Emitter<StartWorkoutState> emit) {
    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (time > 0) {
        time--;
        emit(PlayTimerState(time: time)); // Emit updated time
      } else {
        _timer?.cancel();
      }
    });
  }

  void _pauseTimer() {
    _timer?.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
