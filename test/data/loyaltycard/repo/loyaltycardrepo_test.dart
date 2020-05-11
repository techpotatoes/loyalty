import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:mockito/mockito.dart';

class MockLoyaltyCardBox extends Mock implements LoyaltyCardBox {}
class MockBox<T> extends Mock implements Box<T> {}

void main() {
  final loyaltyCard1 = LoyaltyCard.fromParams('Card1','12345');
  final loyaltyCard2 = LoyaltyCard.fromParams('Card2','54321');
  final loyaltyCardList = [loyaltyCard1, loyaltyCard2];

  group('Given a Loyalty cards repository', () {
    final mockLoyaltyCardBox = MockLoyaltyCardBox();
    final mockBox = MockBox<LoyaltyCard>();
    
    final loyaltyCardRepository = LoyaltyCardRepository(mockLoyaltyCardBox);

    when(mockLoyaltyCardBox.box).thenAnswer((_) async => Future.value(mockBox));
    when(mockBox.values).thenReturn(loyaltyCardList);

    test('should retrieve all LoyaltyCards', () async {
        final result = await loyaltyCardRepository.getAll();

        expect(result, loyaltyCardList);
    });

    test('should save loyalty card in the box', () async { 
      final newCard = LoyaltyCard.fromParams('CardNew','222333');
      
      await loyaltyCardRepository.save(newCard);

      verify(mockBox.add(newCard));
    });

    test('should delete loyalty card from the box', () async { 
      final existingCard = LoyaltyCard.fromParams('ExistingCard','777878');
      
      await loyaltyCardRepository.delete(existingCard);

      verify(mockBox.delete(existingCard.key));
    });

    test('should delete all loyalty card from the box', () async { 
      final existingCardList = [LoyaltyCard.fromParams('ExistingCard','777878')];

      when(mockBox.keys).thenReturn(existingCardList);
      
      await loyaltyCardRepository.deleteAll();

      verify(mockBox.deleteAll(existingCardList));
    });

  });
}