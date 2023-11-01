import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_start_workout/view_model/start_workout_event.dart';
import 'package:gymplus/app/views/view_start_workout/view_model/start_workout_state.dart';


class StartWorkoutViewModel extends Bloc<StartWorkoutEvent, StartWorkoutState> {
  StartWorkoutViewModel() : super(StartWorkoutInitial());

  int time = 0;

  Stream<StartWorkoutState> mapEventToState(
    StartWorkoutEvent event,
  ) async* {
    if (event is BackTappedEvent) {
      yield BackTappedState();
    } else if (event is PlayTappedEvent) {
      time = event.time;
      yield PlayTimerState(time: event.time);
    } else if (event is PauseTappedEvent) {
      time = event.time;
      yield PauseTimerState(currentTime: time);
    }
  }
}