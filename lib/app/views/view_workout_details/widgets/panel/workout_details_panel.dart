import 'package:flutter/material.dart';
import 'package:gymplus/app/views/view_workout_details/widgets/panel/exercises_list.dart';
import 'package:gymplus/app/views/view_workout_details/widgets/panel/workout_tag.dart';
import 'package:gymplus/core/constants/path_constants.dart';
import 'package:gymplus/core/constants/text_constants.dart';
import 'package:gymplus/data/workout_data.dart';

class WorkoutDetailsPanel extends StatelessWidget {
  final WorkoutData workout;

  const WorkoutDetailsPanel({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return _createPanelData();
  }

  Widget _createPanelData() {
    return Column(
      children: [
        const SizedBox(height: 15),
        _createRectangle(),
        const SizedBox(height: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _createHeader(),
              const SizedBox(height: 20),
              _createWorkoutData(),
              const SizedBox(height: 20),
              _createExerciesList(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _createRectangle() {
    return const Image(image: AssetImage(PathConstants.rectangle));
  }

  Widget _createHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        "${workout.title}  ${TextConstants.workout}",
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _createWorkoutData() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          WorkoutTag(
            icon: PathConstants.timeTracker,
            content: "${workout.minutes}:00",
          ),
          const SizedBox(width: 15),
          WorkoutTag(
            icon: PathConstants.exerciseTracker,
            content: "${workout.exercices} ${TextConstants.exercisesLowercase}",
          ),
        ],
      ),
    );
  }

  Widget _createExerciesList() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ExercisesList(exercises: workout.exerciseDataList, workout: workout),
      ),
    );
  }
}