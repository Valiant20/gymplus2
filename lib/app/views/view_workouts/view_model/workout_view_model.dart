import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_workouts/view_model/workout_event.dart';
import 'package:gymplus/app/views/view_workouts/view_model/workout_state.dart';


class WorkoutViewModel extends Bloc<WorkoutsEvent, WorkoutsState> {
  WorkoutViewModel() : super(WorkoutsInitial());

  Stream<WorkoutsState> mapEventToState(
    WorkoutsEvent event,
  ) async* {
    if (event is CardTappedEvent) {
      yield CardTappedState(workout: event.workout);
    }
  }
}