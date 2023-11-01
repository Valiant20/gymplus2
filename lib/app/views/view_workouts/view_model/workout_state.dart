import 'package:gymplus/data/workout_data.dart';

abstract class WorkoutsState {}

class WorkoutsInitial extends WorkoutsState {}

class CardTappedState extends WorkoutsState {
  final WorkoutData workout;

  CardTappedState({required this.workout});
}