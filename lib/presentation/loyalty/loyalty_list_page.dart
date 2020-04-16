import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/domain/loyalty/loyalty_bloc.dart';
import 'package:loyalty/domain/loyalty/loyalty_event.dart';
import 'package:loyalty/domain/loyalty/loyalty_state.dart';

class LoyaltyListPage extends StatefulWidget {
  LoyaltyListPage({Key key}) : super(key: key);

  @override
  _LoyaltyListPageState createState() => _LoyaltyListPageState();
}

class _LoyaltyListPageState extends State<LoyaltyListPage> {

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<LoyaltyBloc>(context).add(Fetch());

    return Scaffold(
        appBar: AppBar(
          title: Text("Loyalty"),
        ),
        body: Container(
          child:
              BlocBuilder<LoyaltyBloc, LoyaltyState>(builder: (_, state) {
            switch (state.runtimeType) {
              case LoyaltyEmpty:
                return _LoyaltyEmptyWidget();
                break;
              case LoyaltyLoading:
                return CircularProgressIndicator();
                break;
              case LoyaltyError:
                return _LoyaltyErrorWidget();
                break;
              case LoyaltyLoaded:
                return _LoyaltyLoadedWidget(loyaltyCards: state.props.first);
                break;
              default:
                return _LoyaltyErrorWidget();
            }
          }),
        ));
  }
}

class _LoyaltyEmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("No items yet. Add some new cards.");
  }
}

class _LoyaltyErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("An error has ocurred");
  }
}

class _LoyaltyLoadedWidget extends StatelessWidget {
  final List<LoyaltyCard> loyaltyCards;

  const _LoyaltyLoadedWidget({Key key, @required this.loyaltyCards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Loaded. cards: ${loyaltyCards.length}");
  }
}
