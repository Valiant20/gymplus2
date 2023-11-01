import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_event.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_state.dart';
import 'package:gymplus/data/workout_data.dart';


class WorkoutDetailsViewModel extends Bloc<WorkoutDetailsEvent, WorkoutDetailsState> {
  final WorkoutData workout;
  WorkoutDetailsViewModel({required this.workout}) : super(WorkoutDetailsInitial());

  Stream<WorkoutDetailsState> mapEventToState(
    WorkoutDetailsEvent event,
  ) async* {
    if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is WorkoutExerciseCellTappedEvent) {
      yield WorkoutExerciseCellTappedState(
        currentExercise: event.currentExercise,
        nextExercise: event.nextExercise,
      );
    }
  }
}