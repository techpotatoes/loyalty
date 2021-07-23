abstract class NavigatorEvent {}

class NavigatorEventPop extends NavigatorEvent {}

class NavigatorEventAdd extends NavigatorEvent {
  final Function andThen;

  NavigatorEventAdd(this.andThen);
}

class NavigatorEventOpenDetail extends NavigatorEvent {
  final String loyaltyCardId;
  final Function andThen;

  NavigatorEventOpenDetail(this.loyaltyCardId, this.andThen);
}
