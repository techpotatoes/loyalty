import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class LoyaltyCard extends HiveObject {

  @HiveField(0)
  String name;

  @HiveField(1)
  String number;
}