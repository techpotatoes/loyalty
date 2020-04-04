import 'package:hive/hive.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

class LoyaltyCardBox { 
  var box = Hive.box<LoyaltyCard>('loyalty_card');
}