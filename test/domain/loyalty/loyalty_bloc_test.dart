import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:loyalty/domain/loyalty/loyalty_bloc.dart';
import 'package:loyalty/domain/loyalty/loyalty_event.dart';
import 'package:loyalty/domain/loyalty/loyalty_state.dart';
import 'package:mockito/mockito.dart';

class MockLoyaltyCardRepository extends Mock implements LoyaltyCardRepository {}

class UnhandledEvent extends LoyaltyEvent {}

void main() {
  final loyaltyCard1 = LoyaltyCard.fromParams('Card1','12345');

  group('Given a Loyalty cards BLoC', () {
    final mockLoyaltyCardRepository = MockLoyaltyCardRepository();
  
    test('should return error state when the event is not handled', () async {
        final loyaltyBloc = LoyaltyBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
        
        loyaltyBloc.add(UnhandledEvent());

        expectLater(
          loyaltyBloc,
          emitsInOrder([LoyaltyEmpty(), LoyaltyError()])
        );
    });

    test('on Fetch should return loaded state when there are more than 0 cards', () async {
        final loyaltyBloc = LoyaltyBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
        when(mockLoyaltyCardRepository.getAll()).thenAnswer((_) async => Future.value([loyaltyCard1]));
        
        loyaltyBloc.add(Fetch());

        expectLater(
          loyaltyBloc,
          emitsInOrder([LoyaltyEmpty(), LoyaltyLoading(), LoyaltyLoaded(loyaltyCards: [loyaltyCard1])])
        );
    });

    test('on Fetch should return empty state when there are 0 cards', () async {
        final loyaltyBloc = LoyaltyBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
        when(mockLoyaltyCardRepository.getAll()).thenAnswer((_) async => Future.value([]));
        
        loyaltyBloc.add(Fetch());

        expectLater(
          loyaltyBloc,
          emitsInOrder([LoyaltyEmpty(), LoyaltyLoading(), LoyaltyEmpty()])
        );
    });

    test('on Fetch should return error state when there is an exception', () async {
        final loyaltyBloc = LoyaltyBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
        when(mockLoyaltyCardRepository.getAll()).thenThrow(Exception());
        
        loyaltyBloc.add(Fetch());

        expectLater(
          loyaltyBloc,
          emitsInOrder([LoyaltyEmpty(), LoyaltyLoading(), LoyaltyError()])
        );
    });

  });
  
}