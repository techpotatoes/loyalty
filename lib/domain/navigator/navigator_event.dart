abstract class NavigatorEvent {}

class NavigatorEventPop extends NavigatorEvent {}

class NavigatorEventAdd extends NavigatorEvent {
  final Function andThen;

  NavigatorEventAdd(this.andThen);
}
