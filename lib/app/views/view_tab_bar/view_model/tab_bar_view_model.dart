
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymplus/app/views/view_tab_bar/view_model/tab_bar_event.dart';
import 'package:gymplus/app/views/view_tab_bar/view_model/tab_bar_state.dart';

class TabBarViewModel extends Bloc<TabBarEvent, TabBarState> {
  TabBarViewModel() : super(TabBarInitial());

  int currentIndex = 0;
  bool isSelected = false;

  Stream<TabBarState> mapEventToState(
    TabBarEvent event,
  ) async* {
    if (event is TabBarItemTappedEvent) {
      currentIndex = event.index;
      yield TabBarItemSelectedState(index: currentIndex);
    }
  }
}