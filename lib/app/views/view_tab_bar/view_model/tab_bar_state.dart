abstract class TabBarState {}

class TabBarInitial extends TabBarState {}

class TabBarItemSelectedState extends TabBarState {
  final int index;

  TabBarItemSelectedState({
    required this.index,
  });
}