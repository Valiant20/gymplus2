import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_start_workout/view_model/start_workout_state.dart';
import 'package:gymplus/app/views/view_start_workout/view_model/start_workout_view_model.dart';
import 'package:gymplus/app/views/view_start_workout/widgets/start_workout_content.dart';
import 'package:gymplus/data/exercise_data.dart';

class StartWorkoutPage extends StatelessWidget {
  final ExerciseData exercise;
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  const StartWorkoutPage(
      {super.key, required this.exercise,
      required this.currentExercise,
      required this.nextExercise});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContext(context),
    );
  }

  BlocProvider<StartWorkoutViewModel> _buildContext(BuildContext context) {
    return BlocProvider<StartWorkoutViewModel>(
      create: (context) => StartWorkoutViewModel(),
      child: BlocConsumer<StartWorkoutViewModel, StartWorkoutState>(
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