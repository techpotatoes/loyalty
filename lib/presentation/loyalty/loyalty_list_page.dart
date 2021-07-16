import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/loyalty/loyalty_bloc.dart';
import 'package:loyalty/domain/loyalty/loyalty_event.dart';
import 'package:loyalty/domain/loyalty/loyalty_state.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';
import 'package:loyalty/presentation/loyalty/loyalty_card_list_widget.dart';

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
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text("Loyalty"),
      ),
      body: BlocBuilder<LoyaltyBloc, LoyaltyState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LoyaltyEmpty:
              return _EmptyWidget();
              break;
            case LoyaltyLoading:
              return Center(child: CircularProgressIndicator());
              break;
            case LoyaltyError:
              return _ErrorWidget();
              break;
            case LoyaltyLoaded:
              return LoyaltyCardListWidget(loyaltyCards: state.props.first);
              break;
            default:
              return _ErrorWidget();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<NavigatorBloc>(context).add(NavigatorEventAdd());
        },
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
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
