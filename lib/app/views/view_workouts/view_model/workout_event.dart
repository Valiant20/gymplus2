import 'package:gymplus/data/workout_data.dart';

abstract class WorkoutsEvent {}

class CardTappedEvent extends WorkoutsEvent {
  final WorkoutData workout;

  CardTappedEvent({required this.workout});
}