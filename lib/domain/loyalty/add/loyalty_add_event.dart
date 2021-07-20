import 'package:equatable/equatable.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

abstract class LoyaltyAddEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Save extends LoyaltyAddEvent {
  final LoyaltyCard loyaltyCard;

  Save(this.loyaltyCard);
}

class Reset extends LoyaltyAddEvent {}
