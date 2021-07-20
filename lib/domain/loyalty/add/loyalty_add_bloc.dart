import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'loyalty_add_event.dart';
import 'loyalty_add_state.dart';

class LoyaltyAddBloc extends Bloc<LoyaltyAddEvent, LoyaltyAddState> {
  final LoyaltyCardRepository loyaltyCardRepository;

  LoyaltyAddBloc({@required this.loyaltyCardRepository})
      : super(LoyaltyAddAdding());

  @override
  Stream<LoyaltyAddState> mapEventToState(LoyaltyAddEvent event) async* {
    switch (event.runtimeType) {
      case Save:
        try {
          yield LoyaltyAddSaving();
          await _saveLoyaltyCard((event as Save).loyaltyCard);
          yield LoyaltyAddSaved();
        } catch (_) {
          yield LoyaltyAddError();
        }
        break;
      case Reset:
        yield LoyaltyAddAdding();
        break;
      default:
        yield LoyaltyAddError();
    }
  }

  Future<void> _saveLoyaltyCard(LoyaltyCard loyaltyCard) async {
    return loyaltyCardRepository.save(loyaltyCard);
  }
}
