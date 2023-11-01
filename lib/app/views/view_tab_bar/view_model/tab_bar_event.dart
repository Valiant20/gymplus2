abstract class TabBarEvent {}

class TabBarItemTappedEvent extends TabBarEvent {
  final int index;

  TabBarItemTappedEvent({
    required this.index,
  });
}