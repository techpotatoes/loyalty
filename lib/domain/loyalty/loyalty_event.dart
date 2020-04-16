import 'package:equatable/equatable.dart';

abstract class LoyaltyEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends LoyaltyEvent {}