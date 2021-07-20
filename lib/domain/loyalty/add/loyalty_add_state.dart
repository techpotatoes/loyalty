import 'package:equatable/equatable.dart';

abstract class LoyaltyAddState extends Equatable {
  const LoyaltyAddState();

  @override
  List<Object> get props => [];
}

class LoyaltyAddAdding extends LoyaltyAddState {}

class LoyaltyAddError extends LoyaltyAddState {}

class LoyaltyAddSaving extends LoyaltyAddState {}

class LoyaltyAddSaved extends LoyaltyAddState {}
