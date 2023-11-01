import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_event.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_state.dart';
import 'package:gymplus/app/views/view_workout_details/view_model/workout_details_view_model.dart';
import 'package:gymplus/core/constants/color_constants.dart';
import 'package:gymplus/core/constants/path_constants.dart';
import 'package:gymplus/data/workout_data.dart';

class WorkoutDetailsBody extends StatelessWidget {
  final WorkoutData workout;
  const WorkoutDetailsBody({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: ColorConstants.white,
      child: Stack(
        children: [
          _createImage(),
          _createBackButton(context),
        ],
      ),
    );
  }

  Widget _createBackButton(BuildContext context) {
    final bloc = BlocProvider.of<WorkoutDetailsViewModel>(context);
    return Positioned(
      left: 20,
      top: 14,
      child: SafeArea(
        child: BlocBuilder<WorkoutDetailsViewModel, WorkoutDetailsState>(
          builder: (context, state) {
            return GestureDetector(
              child: const SizedBox(
                width: 30,
                height: 30,
                child: Image(
                  image: AssetImage(PathConstants.back),
                ),
              ),
              onTap: () {
                bloc.add(BackTappedEvent());
              },
            );
          },
        ),
      ),
    );
  }

  Widget _createImage() {
    return SizedBox(
      width: double.infinity,
      child: Image(
        image: AssetImage(workout.image),
        fit: BoxFit.cover,
      ),
    );
  }
}