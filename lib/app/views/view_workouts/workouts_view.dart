import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_workout_details/workout_details_view.dart';
import 'package:gymplus/app/views/view_workouts/view_model/workout_state.dart';
import 'package:gymplus/app/views/view_workouts/view_model/workout_view_model.dart';
import 'package:gymplus/app/views/view_workouts/widgets/workout_content.dart';

class WorkoutsPage extends StatelessWidget {
  const WorkoutsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildContext(context));
  }

  BlocProvider<WorkoutViewModel> _buildContext(BuildContext context) {
    return BlocProvider<WorkoutViewModel>(
      create: (context) => WorkoutViewModel(),
      child: BlocConsumer<WorkoutViewModel, WorkoutsState>(
        buildWhen: (_, currState) => currState is WorkoutsInitial,
        builder: (context, state) {
          return const WorkoutContent();
        },
        listenWhen: (_, currState) => currState is CardTappedState,
        listener: (context, state) {
          if (state is CardTappedState) {
            Navigator.of(context, rootNavigator: true).push(
              MaterialPageRoute(
                builder: (_) => WorkoutDetailsPage(workout: state.workout),
              ),
            );
          }
        },
      ),
    );
  }
}