import 'package:equatable/equatable.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

abstract class LoyaltyDetailState extends Equatable {
  const LoyaltyDetailState();

  @override
  List<Object> get props => [];
}

class LoyaltyDetailInitial extends LoyaltyDetailState {}

class LoyaltyDetailLoading extends LoyaltyDetailState {}

class LoyaltyDetailError extends LoyaltyDetailState {}

class LoyaltyDetailDeleted extends LoyaltyDetailState {}

class LoyaltyDetailLoaded extends LoyaltyDetailState {
  final LoyaltyCard loyaltyCard;

  const LoyaltyDetailLoaded(this.loyaltyCard);

  @override
  List<Object> get props => [loyaltyCard];
}
