import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_onboarding/view_model/onboarding_event.dart';
import 'package:gymplus/app/views/view_onboarding/view_model/onboarding_state.dart';


class OnboardingViewModel extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingViewModel() : super(OnboardingInitial());

  int pageIndex = 0;

  final pageController = PageController(initialPage: 0);

  Stream<OnboardingState> mapEventToState(
    OnboardingEvent event,
  ) async* {
    if (event is PageChangedEvent) {
      if (pageIndex == 2) {
        yield NextScreenState();
        return;
      }
      pageIndex += 1;

      pageController.animateToPage(
        pageIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );

      yield PageChangedState(counter: pageIndex);
    } else if (event is PageSwipedEvent) {
      pageIndex = event.index;
      yield PageChangedState(counter: pageIndex);
    }
  }
}