import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:mockito/mockito.dart';

class MockLoyaltyCardBox extends Mock implements LoyaltyCardBox {}
class MockBox<T> extends Mock implements Box<T> {}

void main() {
  final loyaltyCard1 = LoyaltyCard('Card1','12345');
  final loyaltyCard2 = LoyaltyCard('Card2','54321');
  final loyaltyCardList = [loyaltyCard1, loyaltyCard2];

  group('Given a Loyalty cards repository', () {
    final mockLoyaltyCardBox = MockLoyaltyCardBox();
    final mockBox = MockBox<LoyaltyCard>();
    final loyaltyCardRepository = LoyaltyCardRepository(mockLoyaltyCardBox);

    when(mockLoyaltyCardBox.box).thenReturn(mockBox);
    when(mockBox.values).thenReturn(loyaltyCardList);

    test('should retrieve all LoyaltyCards', () {
        final result = loyaltyCardRepository.getAll();

        expect(result, loyaltyCardList);
    });

    test('should save loyalty card in the box', () { 
      final newCard = LoyaltyCard('CardNew','222333');
      
      loyaltyCardRepository.save(newCard);

      verify(mockBox.add(newCard));
    });

    test('should delete loyalty card from the box', () { 
      final existingCard = LoyaltyCard('ExistingCard','777878');
      
      loyaltyCardRepository.delete(existingCard);

      verify(mockBox.delete(existingCard.key));
    });

  });
}