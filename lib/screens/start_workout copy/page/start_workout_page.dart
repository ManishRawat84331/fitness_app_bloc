import 'package:fitness_app/data/exercise_data.dart';
import 'package:fitness_app/screens/start_workout%20copy/bloc/start_workout_bloc.dart';
import 'package:fitness_app/screens/start_workout%20copy/widget/start_workout_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StartWorkoutPage extends StatelessWidget {
  final ExerciseData exercise;
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  StartWorkoutPage(
      {required this.exercise,
      required this.currentExercise,
      required this.nextExercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<StartWorkoutBloc> _buildContext(BuildContext context) {
    return BlocProvider<StartWorkoutBloc>(
      create: (context) => StartWorkoutBloc(),
      child: BlocConsumer<StartWorkoutBloc, StartWorkoutState>(
        buildWhen: (_, currState) => currState is StartWorkoutInitial,
        builder: (context, state) {
          return StartWorkoutContent(
            exercise: exercise,
            nextExercise: nextExercise,
          );
        },
        listenWhen: (_, currState) => currState is BackTappedState,
        listener: (context, state) {
          if (state is BackTappedState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
