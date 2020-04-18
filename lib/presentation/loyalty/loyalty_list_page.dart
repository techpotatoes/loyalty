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
  void initState() {
    super.initState();
    BlocProvider.of<LoyaltyBloc>(context).add(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Loyalty"),
        ),
        body: Container(
          child:
              BlocBuilder<LoyaltyBloc, LoyaltyState>(builder: (_, state) {
            switch (state.runtimeType) {
              case LoyaltyEmpty:
                return _EmptyWidget();
                break;
              case LoyaltyLoading:
                return CircularProgressIndicator();
                break;
              case LoyaltyError:
                return _ErrorWidget();
                break;
              case LoyaltyLoaded:
                return _LoadedWidget(loyaltyCards: state.props.first);
                break;
              default:
                return _ErrorWidget();
            }
          }),
        ));
  }
}

class _EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("No items yet. Add some new cards.");
  }
}

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("An error has ocurred");
  }
}

class _LoadedWidget extends StatelessWidget {
  final List<LoyaltyCard> loyaltyCards;

  const _LoadedWidget({Key key, @required this.loyaltyCards})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text("Loaded. cards: ${loyaltyCards.length}");
  }
}
