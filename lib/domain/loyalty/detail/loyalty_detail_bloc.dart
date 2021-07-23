import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';

import 'loyalty_detail_event.dart';
import 'loyalty_detail_state.dart';

class LoyaltyDetailBloc extends Bloc<LoyaltyDetailEvent, LoyaltyDetailState> {
  final LoyaltyCardRepository loyaltyCardRepository;

  LoyaltyDetailBloc({@required this.loyaltyCardRepository})
      : super(LoyaltyDetailInitial());

  @override
  Stream<LoyaltyDetailState> mapEventToState(LoyaltyDetailEvent event) async* {
    switch (event.runtimeType) {
      case DeleteDetail:
        try {
          yield LoyaltyDetailLoading();
          await _deleteLoyaltyCard((event as DeleteDetail).loyaltyCard);
          yield LoyaltyDetailDeleted();
        } catch (_) {
          yield LoyaltyDetailError();
        }
        break;
      case FetchDetail:
        try {
          yield LoyaltyDetailLoading();
          final _loyaltyCard =
              await _fetchLoyaltyCard((event as FetchDetail).loyaltyCardId);
          if (_loyaltyCard != null) {
            yield LoyaltyDetailLoaded(_loyaltyCard);
          } else {
            yield LoyaltyDetailError();
          }
        } catch (_) {
          yield LoyaltyDetailError();
        }
        break;
      default:
        yield LoyaltyDetailError();
    }
  }

  Future<LoyaltyCard> _fetchLoyaltyCard(String loyaltyCardId) async {
    return loyaltyCardRepository.getById(loyaltyCardId);
  }

  Future<void> _deleteLoyaltyCard(LoyaltyCard loyaltyCard) async {
    return loyaltyCardRepository.delete(loyaltyCard);
  }
}
