import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';

class LoyaltyDetailBarcodeWidget extends StatelessWidget {
  final LoyaltyCard loyaltyCard;

  const LoyaltyDetailBarcodeWidget({Key key, @required this.loyaltyCard})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarCodeImage(
      params: EAN13BarCodeParams(
        loyaltyCard.number,
        lineWidth: 2.0,
        barHeight: 90.0,
        withText: true,
      ),
      onError: (error) {
        // Error handler
        print('error = $error');
      },
    );
  }
}
