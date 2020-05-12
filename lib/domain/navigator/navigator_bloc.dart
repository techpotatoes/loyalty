import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/navigator/navigator_action.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic>{
  
  final GlobalKey<NavigatorState> navigatorKey;
  
  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => "Initial";

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    if(event is NavigatorActionPop){
      navigatorKey.currentState.pop();
    }else if(event is NavigatorActionAdd){
      navigatorKey.currentState.pushNamed('/add');
    }
    yield "Updated";
  }
}


