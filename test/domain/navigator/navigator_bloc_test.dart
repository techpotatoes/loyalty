import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty/domain/navigator/navigator_action.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';
import 'package:mockito/mockito.dart';

class MockNavigatorKey extends Mock implements GlobalKey<NavigatorState> {}

class MockCurrentState extends Mock implements NavigatorState {
  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.debug}) =>
      super.toString();
}

void main() {
  group('Given a Navigator BLoC', () {
    final mockNavigatorKey = MockNavigatorKey();
    final mockCurrentState = MockCurrentState();
    when(mockNavigatorKey.currentState).thenReturn(mockCurrentState);

    test('should pop navigator when NavigatorActionPop', () {
      final navigatorBloc = NavigatorBloc(navigatorKey: mockNavigatorKey);

      navigatorBloc.add(NavigatorEventPop());

      expectLater(navigatorBloc, emitsInOrder(["Initial", "Updated"]))
          .then((value) => verify(mockCurrentState.pop()));
    });

    test('should push named when NavigatorActionAdd', () {
      final navigatorBloc = NavigatorBloc(navigatorKey: mockNavigatorKey);

      navigatorBloc.add(NavigatorEventAdd());

      expectLater(navigatorBloc, emitsInOrder(["Initial", "Updated"]))
          .then((value) => verify(mockCurrentState.pushNamed('/add')));
    });
  });
}
