import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_onboarding/view_model/onboarding_state.dart';
import 'package:gymplus/app/views/view_onboarding/view_model/onboarding_view_model.dart';
import 'package:gymplus/app/views/view_onboarding/widgets/onboarding_content.dart';
import 'package:gymplus/app/views/view_sign_up/sign_up_view.dart';

class OnboardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  BlocProvider<OnboardingViewModel> _buildBody(BuildContext context) {
    return BlocProvider<OnboardingViewModel>(
      create: (BuildContext context) => OnboardingViewModel(),
      child: BlocConsumer<OnboardingViewModel, OnboardingState>(
        listenWhen: (_, currState) => currState is NextScreenState,
        listener: (context, state) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) {
                return SignUpPage();
              },
            ),
          );
        },
        buildWhen: (_, currState) => currState is OnboardingInitial,
        builder: (context, state) {
          return OnboardingContent();
        },
      ),
    );
  }
}