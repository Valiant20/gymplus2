import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_event.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_state.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_view_model.dart';
import 'package:gymplus/core/constants/color_constants.dart';
import 'package:gymplus/core/constants/path_constants.dart';
import 'package:gymplus/data/exercise_data.dart';
import 'package:gymplus/data/workout_data.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ExercisesList extends StatelessWidget {
  final WorkoutData workout;
  final List<ExerciseData> exercises;

  const ExercisesList({super.key, required this.exercises, required this.workout});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.only(top: 10),
      itemCount: exercises.length,
      itemBuilder: (context, index) {
        return ExerciseCell(
          currentExercise: exercises[index],
          nextExercise: index == exercises.length - 1 ? null : exercises[index + 1],
          workout: workout,
        );
      },
      separatorBuilder: (context, index) {
        return const SizedBox(height: 15);
      },
    );
  }
}

class ExerciseCell extends StatelessWidget {
  final WorkoutData workout;
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  const ExerciseCell({super.key, 
    required this.currentExercise,
    required this.workout,
    required this.nextExercise,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutDetailsViewModel>(context);
    return BlocBuilder<WorkoutDetailsViewModel, WorkoutDetailsState>(
      buildWhen: (_, currState) => currState is WorkoutExerciseCellTappedState,
      builder: (context, state) {
        return InkWell(
          borderRadius: BorderRadius.circular(40),
          onTap: () {
            bloc.add(
              WorkoutExerciseCellTappedEvent(
                currentExercise: currentExercise,
                nextExercise: nextExercise,
              ),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 10, right: 25, top: 10, bottom: 10),
            decoration: BoxDecoration(
              color: ColorConstants.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: ColorConstants.textBlack.withOpacity(0.12),
                  blurRadius: 5.0,
                  spreadRadius: 1.1,
                ),
              ],
            ),
            child: Row(
              children: [
                _createImage(),
                const SizedBox(width: 10),
                Expanded(
                  child: _createExerciseTextInfo(),
                ),
                const SizedBox(width: 10),
                _createRightArrow(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _createImage() {
    return Container(
      width: 75,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        image: DecorationImage(
          image: AssetImage(workout.image),
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _createExerciseTextInfo() {
    final minutesStr = "${currentExercise.minutes} minutes";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          currentExercise.title,
          style: const TextStyle(
            color: ColorConstants.textColor,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          minutesStr,
          style: const TextStyle(
            color: ColorConstants.textBlack,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 11),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: LinearPercentIndicator(
            percent: currentExercise.progress,
            progressColor: ColorConstants.primaryColor,
            backgroundColor: ColorConstants.primaryColor.withOpacity(0.12),
            lineHeight: 6,
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Widget _createRightArrow() {
    return const RotatedBox(
      quarterTurns: 2,
      child: Image(
        image: AssetImage(PathConstants.back),
      ),
    );
  }
}