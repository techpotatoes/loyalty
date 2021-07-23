import 'package:equatable/equatable.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

abstract class LoyaltyDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchDetail extends LoyaltyDetailEvent {
  final String loyaltyCardId;

  FetchDetail(this.loyaltyCardId);
}

class DeleteDetail extends LoyaltyDetailEvent {
  final LoyaltyCard loyaltyCard;

  DeleteDetail(this.loyaltyCard);
}
