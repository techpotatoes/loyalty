import 'package:flutter_test/flutter_test.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:loyalty/domain/loyalty/detail/loyalty_detail_bloc.dart';
import 'package:loyalty/domain/loyalty/detail/loyalty_detail_event.dart';
import 'package:loyalty/domain/loyalty/detail/loyalty_detail_state.dart';
import 'package:mockito/mockito.dart';

class MockLoyaltyCardRepository extends Mock implements LoyaltyCardRepository {}

class UnhandledEvent extends LoyaltyDetailEvent {}

void main() {
  final loyaltyCard1 = LoyaltyCard.fromParams('Card1', '12345');

  group('Given a LoyaltyDetail cards BLoC', () {
    final mockLoyaltyCardRepository = MockLoyaltyCardRepository();

    test('should start with initial state', () async {
      final loyaltyDetailBloc =
          LoyaltyDetailBloc(loyaltyCardRepository: mockLoyaltyCardRepository);

      expectLater(loyaltyDetailBloc.state, LoyaltyDetailInitial());
    });

    test('should return error state when the event is not handled', () async {
      final loyaltyDetailBloc =
          LoyaltyDetailBloc(loyaltyCardRepository: mockLoyaltyCardRepository);

      loyaltyDetailBloc.add(UnhandledEvent());

      expectLater(
          loyaltyDetailBloc.stream, emitsInOrder([LoyaltyDetailError()]));
    });

    test('on Delete should return deleted if sucessful', () async {
      final loyaltyDetailBloc =
          LoyaltyDetailBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
      when(mockLoyaltyCardRepository.delete(loyaltyCard1));

      loyaltyDetailBloc.add(DeleteDetail(loyaltyCard1));

      expectLater(loyaltyDetailBloc.stream,
          emitsInOrder([LoyaltyDetailLoading(), LoyaltyDetailDeleted()]));
    });

    test('on Delete should return error state when there is an exception',
        () async {
      resetMockitoState();
      final loyaltyDetailBloc =
          LoyaltyDetailBloc(loyaltyCardRepository: mockLoyaltyCardRepository);
      when(mockLoyaltyCardRepository.delete(loyaltyCard1))
          .thenThrow(Exception());

      loyaltyDetailBloc.add(DeleteDetail(loyaltyCard1));

      expectLater(loyaltyDetailBloc.stream,
          emitsInOrder([LoyaltyDetailLoading(), LoyaltyDetailError()]));
    });
  });
}
