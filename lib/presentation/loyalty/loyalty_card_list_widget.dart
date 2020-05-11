import 'package:flutter/material.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

class LoyaltyCardListWidget extends StatelessWidget {
  final List<LoyaltyCard> loyaltyCards;

  const LoyaltyCardListWidget({Key key, @required this.loyaltyCards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: loyaltyCards.length,
        itemBuilder: (BuildContext context, int index) {
          return _LoyaltyCardItemWidget(loyaltyCard: loyaltyCards[index]);
        });
  }
}

class _LoyaltyCardItemWidget extends StatelessWidget {
  final LoyaltyCard loyaltyCard;

  _LoyaltyCardItemWidget({Key key, @required this.loyaltyCard}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.blueAccent,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            print('Card tapped.');
          },
          child: Container(
            width: 300,
            height: 100,
            child: Column(
              children: <Widget>[
                Text(loyaltyCard.number),
                Text(loyaltyCard.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
