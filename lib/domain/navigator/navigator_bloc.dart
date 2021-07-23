import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';
import 'package:loyalty/presentation/loyalty/detail/loyalty_detail_page.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({this.navigatorKey}) : super("Initial");

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorEventPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigatorEventAdd) {
      navigatorKey.currentState
          .pushNamed('/add')
          .then((value) => event.andThen.call());
    } else if (event is NavigatorEventOpenDetail) {
      navigatorKey.currentState
          .pushNamed('/detail', arguments: event.loyaltyCardId)
          .then((value) => event.andThen.call());
    }
    yield "Updated";
  }
}
