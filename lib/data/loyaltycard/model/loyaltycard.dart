import 'package:hive/hive.dart';

part 'loyaltycard.g.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {

  LoyaltyCard();

  LoyaltyCard.fromParams(this.name, this.number);
  @HiveField(0)
  String name;

  @HiveField(1)
  String number;
}