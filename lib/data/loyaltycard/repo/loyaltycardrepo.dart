import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/repository.dart';

class LoyaltyCardRepository implements Repository<LoyaltyCard> {

  LoyaltyCardBox loyaltyCardBox;
  
  LoyaltyCardRepository(LoyaltyCardBox loyaltyCardBox) {
    this.loyaltyCardBox = loyaltyCardBox;
  }

  @override
  List<LoyaltyCard> getAll() => loyaltyCardBox.box.values.toList();

  @override
  void save(LoyaltyCard newObject) {
    loyaltyCardBox.box.add(newObject);
  } 

  @override
  void delete(LoyaltyCard objectToDelete) {
    loyaltyCardBox.box.delete(objectToDelete.key);
  } 

}