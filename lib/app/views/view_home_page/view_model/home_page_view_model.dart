import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_home_page/view_model/home_page_event.dart';
import 'package:gymplus/app/views/view_home_page/view_model/home_page_state.dart';

class HomePageViewModel extends Bloc<HomeEvent, HomeState> {
  HomePageViewModel() : super(HomeInitial());

  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is ReloadImageEvent) {
      yield ReloadImageState();
    }
  }
}