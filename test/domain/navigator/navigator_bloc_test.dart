// ignore_for_file: invalid_override_different_default_values_named, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorKey extends Mock implements GlobalKey<NavigatorState> {}

class MockCurrentState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) =>
      super.toString();
}

abstract class MyFunction {
  void call() {
    print("called");
  }
}

class MockFunction extends Mock implements MyFunction {}

void main() {
  group('Given a Navigator BLoC', () {
    final mockNavigatorKey = MockNavigatorKey();
    final mockCurrentState = MockCurrentState();
    when(mockNavigatorKey.currentState).thenReturn(mockCurrentState);
    when(mockCurrentState.pushNamed(any))
        .thenAnswer((realInvocation) => Future.sync(() => {}));

    test('should open with Initial State', () {
      final navigatorBloc = NavigatorBloc(navigatorKey: mockNavigatorKey);

      expectLater(navigatorBloc.state, "Initial");
    });

    test('should pop navigator when NavigatorActionPop', () {
      final navigatorBloc = NavigatorBloc(navigatorKey: mockNavigatorKey);

      navigatorBloc.add(NavigatorEventPop());

      expectLater(navigatorBloc.stream, emitsInOrder(["Updated"]))
          .then((value) => verify(mockCurrentState.pop()));
    });

    test('should push named when NavigatorActionAdd and call function', () {
      final mockFunction = MockFunction();
      final navigatorBloc = NavigatorBloc(navigatorKey: mockNavigatorKey);

      navigatorBloc.add(NavigatorEventAdd(mockFunction));

      expectLater(navigatorBloc.stream, emitsInOrder(["Updated"]))
          .then((value) => verify(mockCurrentState.pushNamed('/add')))
          .then((value) => verify(mockFunction()).called(1));
    });
  });
}
