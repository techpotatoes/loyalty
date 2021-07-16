import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({this.navigatorKey}) : super(null);

  @override
  dynamic get initialState => "Initial";

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is NavigatorEventPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigatorEventAdd) {
      navigatorKey.currentState.pushNamed('/add');
    }
    yield "Updated";
  }
}
