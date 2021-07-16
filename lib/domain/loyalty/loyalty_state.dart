import 'package:equatable/equatable.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

abstract class LoyaltyState extends Equatable {
  const LoyaltyState();

  @override
  List<Object> get props => [];
}

class LoyaltyEmpty extends LoyaltyState {}

class LoyaltyError extends LoyaltyState {}

class LoyaltyLoading extends LoyaltyState {}

class LoyaltyLoaded extends LoyaltyState {
  final List<LoyaltyCard> loyaltyCards;

  const LoyaltyLoaded({this.loyaltyCards});

  @override
  List<Object> get props => [loyaltyCards];
}
