import 'package:gymplus/data/exercise_data.dart';

abstract class WorkoutDetailsEvent {}

class BackTappedEvent extends WorkoutDetailsEvent {}

class WorkoutExerciseCellTappedEvent extends WorkoutDetailsEvent {
  final ExerciseData currentExercise;
  final ExerciseData? nextExercise;

  WorkoutExerciseCellTappedEvent({
    required this.currentExercise,
    required this.nextExercise,
  });
}