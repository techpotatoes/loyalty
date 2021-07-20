import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:loyalty/domain/loyalty/add/loyalty_add_bloc.dart';
import 'package:loyalty/domain/loyalty/add/loyalty_add_event.dart';
import 'package:loyalty/domain/loyalty/add/loyalty_add_state.dart';
import 'package:mockito/mockito.dart';

class MockLoyaltyCardRepository extends Mock implements LoyaltyCardRepository {}

class UnhandledEvent extends LoyaltyAddEvent {}

void main() {
  final loyaltyCard1 = LoyaltyCard.fromParams('Card1', '12345');

  group('Given a LoyaltyAdd cards BLoC', () {
    final mockLoyaltyCardRepository = MockLoyaltyCardRepository();

    test('should start with adding state', () async {
      final loyaltyAddBloc =
          LoyaltyAddBloc(loyaltyCardRepository: mockLoyaltyCardRepository);

      expectLater(loyaltyAddBloc.state, LoyaltyAddAdding());
    });

    test('should return error state when the event is not handled', () async {
      final loyaltyAddBloc =
          LoyaltyAddBloc(loyaltyCardRepository: mockLoyaltyCardRepository);

      loyaltyAddBloc.add(UnhandledEvent());

      expectLater(loyaltyAddBloc.stream, emitsInOrder([LoyaltyAddError()]));
    });

    test('on Save should return saved if sucessful', () async {
      final loyaltyAddBloc =
          LoyaltyAddBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
      when(mockLoyaltyCardRepository.save(loyaltyCard1));

      loyaltyAddBloc.add(Save(loyaltyCard1));

      expectLater(loyaltyAddBloc.stream,
          emitsInOrder([LoyaltyAddSaving(), LoyaltyAddSaved()]));
    });

    test('on Save should return error when it fails saving', () async {
      final loyaltyAddBloc =
          LoyaltyAddBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
      resetMockitoState();
      when(mockLoyaltyCardRepository.save(loyaltyCard1)).thenThrow(Exception());

      loyaltyAddBloc.add(Save(loyaltyCard1));

      expectLater(loyaltyAddBloc.stream,
          emitsInOrder([LoyaltyAddSaving(), LoyaltyAddError()]));
    });

    test('on Reset should return adding state', () async {
      final loyaltyAddBloc =
          LoyaltyAddBloc(loyaltyCardRepository: mockLoyaltyCardRepository);

      loyaltyAddBloc.add(Reset());

      expectLater(loyaltyAddBloc.stream, emitsInOrder([LoyaltyAddAdding()]));
    });
  });
}
