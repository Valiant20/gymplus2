import 'package:flutter/material.dart';
import 'package:gymplus/app/views/view_workout_details/widgets/panel/workout_details_panel.dart';
import 'package:gymplus/app/views/view_workout_details/widgets/workout_details_body.dart';
import 'package:gymplus/core/constants/color_constants.dart';
import 'package:gymplus/data/workout_data.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class WorkoutDetailsContent extends StatelessWidget {
  final WorkoutData workout;

  const WorkoutDetailsContent({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: _createSlidingUpPanel(context),
    );
  }

  Widget _createSlidingUpPanel(BuildContext context) {
    return SlidingUpPanel(
      panel: WorkoutDetailsPanel(workout: workout),
      body: WorkoutDetailsBody(workout: workout),
      minHeight: MediaQuery.of(context).size.height * 0.65,
      maxHeight: MediaQuery.of(context).size.height * 0.87,
      isDraggable: true,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(50),
        topRight: Radius.circular(50),
      ),
    );
  }
}