import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';

class LoyaltyAddPage extends StatelessWidget {
  const LoyaltyAddPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
          BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventPop());
          return Future(() => true);
        },
        child: Scaffold(
          backgroundColor: Color(0xFFF6F6F6),
          appBar: AppBar(
            title: Text("Loyalty"),
          ),
          body: Container(
            child: Center(
              child: Text("Adding"),
            ),
          ),
        ));
  }
}
