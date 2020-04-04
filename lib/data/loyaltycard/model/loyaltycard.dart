import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {

  LoyaltyCard(String name, String number) {
    this.name =  name;
    this.number = number;
  }

  @HiveField(0)
  String name;

  @HiveField(1)
  String number;
}