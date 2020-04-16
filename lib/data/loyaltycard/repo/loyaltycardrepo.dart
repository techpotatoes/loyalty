import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/repository.dart';

class LoyaltyCardRepository implements Repository<LoyaltyCard> {

  LoyaltyCardBox loyaltyCardBox;
  
  LoyaltyCardRepository(LoyaltyCardBox loyaltyCardBox) {
    this.loyaltyCardBox = loyaltyCardBox;
  }

  @override
  Future<List<LoyaltyCard>> getAll() async {
     final box = await loyaltyCardBox.box;
     return box.values.toList();
  }

  @override
  Future<void> save(LoyaltyCard newObject) async {
    final box = await loyaltyCardBox.box;

    box.add(newObject);
  } 

  @override
  Future<void> delete(LoyaltyCard objectToDelete) async {
    final box = await loyaltyCardBox.box;

    box.delete(objectToDelete.key);
  } 

}