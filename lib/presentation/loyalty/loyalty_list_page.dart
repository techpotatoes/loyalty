import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/loyalty/loyalty_bloc.dart';
import 'package:loyalty/domain/loyalty/loyalty_state.dart';

class LoyaltyListPage extends StatefulWidget {
  LoyaltyListPage({Key key}) : super(key: key);

  @override
  _LoyaltyListPageState createState() => _LoyaltyListPageState();
}

class _LoyaltyListPageState extends State<LoyaltyListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Loyalty"),
        ),
        body: Center(
          child:
              BlocBuilder<LoyaltyBloc, LoyaltyState>(builder: (context, state) {
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
                return _LoyaltyLoadedWidget((state as LoyaltyLoaded).props.);
                break;
              default:
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
  
  @override
  Widget build(BuildContext context) {
    return Text("An error has ocurred");
  }
}