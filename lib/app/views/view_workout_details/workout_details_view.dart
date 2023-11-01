import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_start_workout/start_workout_view.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_state.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_view_model.dart';
import 'package:gymplus/app/views/view_workout_details/widgets/workout_details_content.dart';
import 'package:gymplus/app/widgets/fitness_button.dart';
import 'package:gymplus/core/constants/text_constants.dart';
import 'package:gymplus/core/extention/list_extentions.dart';
import 'package:gymplus/data/exercise_data.dart';
import 'package:gymplus/data/workout_data.dart';

class WorkoutDetailsPage extends StatelessWidget {
  final WorkoutData workout;
  const WorkoutDetailsPage({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return _buildContext(context);
  }

  BlocProvider<WorkoutDetailsViewModel> _buildContext(BuildContext context) {
    return BlocProvider<WorkoutDetailsViewModel>(
      create: (context) => WorkoutDetailsViewModel(workout: workout),
      child: BlocConsumer<WorkoutDetailsViewModel, WorkoutDetailsState>(
        buildWhen: (_, currState) => currState is WorkoutDetailsInitial,
        builder: (context, state) {
          return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: FitnessButton(
                  title: TextConstants.start,
                  onTap: () {
                    ExerciseData? exercise = workout.exerciseDataList.firstWhereOrNull((element) => element.progress < 1);
                    exercise ??= workout.exerciseDataList.first;
                    int exerciseIndex = workout.exerciseDataList.indexOf(exercise);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                                value: BlocProvider.of<WorkoutDetailsViewModel>(context),
                                child: StartWorkoutPage(
                                  exercise: exercise!,
                                  currentExercise: exercise,
                                  nextExercise: exerciseIndex + 1 < workout.exerciseDataList.length ? workout.exerciseDataList[exerciseIndex + 1] : null,
                                ),
                              )),
                    );
                  },
                ),
              ),
              body: WorkoutDetailsContent(workout: workout));
        },
        listenWhen: (_, currState) => currState is BackTappedState || currState is WorkoutExerciseCellTappedState,
        listener: (context, state) {
          if (state is BackTappedState) {
            Navigator.pop(context);
          } else if (state is WorkoutExerciseCellTappedState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                        value: BlocProvider.of<WorkoutDetailsViewModel>(context),
                        child: StartWorkoutPage(
                          exercise: state.currentExercise,
                          currentExercise: state.currentExercise,
                          nextExercise: state.nextExercise,
                        ),
                      )),
            );
          }
        },
      ),
    );
  }
}