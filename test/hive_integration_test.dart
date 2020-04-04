import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';

void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(LoyaltyCardAdapter());
  
  //Always starts from a clean box  
  Hive.deleteBoxFromDisk('loyalty_card');
    
  //Warm up boxes
  await Hive.openBox<LoyaltyCard>('loyalty_card');
}

void main() async {
  initialiseHive();

  final newCard = LoyaltyCard.fromParams('New card', '12345');

  group('Given a real loyalty cards repository instance and a real Hive box', () {
    test('should save and then retrieve saved loyalty card from the repository', () {
        final loyaltyCardRepository = LoyaltyCardRepository(LoyaltyCardBox());

        loyaltyCardRepository.save(newCard);

        expect(loyaltyCardRepository.getAll(), [newCard]);
    });
  });
}