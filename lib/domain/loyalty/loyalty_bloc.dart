import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:loyalty/domain/loyalty/loyalty_event.dart';
import 'package:loyalty/domain/loyalty/loyalty_state.dart';

class LoyaltyBloc extends Bloc<LoyaltyEvent, LoyaltyState>{
  final LoyaltyCardRepository loyaltyCardRepository;

  LoyaltyBloc({@required this.loyaltyCardRepository});

  @override
  LoyaltyState get initialState => LoyaltyEmpty();

  @override
  Stream<LoyaltyState> mapEventToState(LoyaltyEvent event) async* {
    switch (event.runtimeType) {
      case Fetch:
        try {     
          final _loyaltyCards = await _fetchLoyaltyCards();
          yield LoyaltyLoaded(loyaltyCards: _loyaltyCards);
        } catch(_) {
          yield LoyaltyError();
        }
        break;
      default: 
        yield LoyaltyError();
    }
  }
  
  Future<List<LoyaltyCard>> _fetchLoyaltyCards() async {
    return loyaltyCardRepository.getAll();
  }
}