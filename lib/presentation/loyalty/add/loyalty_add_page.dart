import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/domain/loyalty/add/loyalty_add_bloc.dart';
import 'package:loyalty/domain/loyalty/add/loyalty_add_event.dart';
import 'package:loyalty/domain/loyalty/add/loyalty_add_state.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';

class LoyaltyAddPage extends StatefulWidget {
  const LoyaltyAddPage({Key key}) : super(key: key);

  @override
  _LoyaltyAddPageState createState() => _LoyaltyAddPageState();
}

class _LoyaltyAddPageState extends State<LoyaltyAddPage> {
  final _textNameController = TextEditingController();
  final _textNumberController = TextEditingController();

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
            title: Text("New loyalty card"),
            actions: [
              BlocBuilder<LoyaltyAddBloc, LoyaltyAddState>(builder: (_, state) {
                switch (state.runtimeType) {
                  case LoyaltyAddAdding:
                    return Padding(
                        padding: EdgeInsets.only(right: 20.0),
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<LoyaltyAddBloc>(context).add(
                              Save(
                                LoyaltyCard.fromParams(
                                  _textNameController.value.text,
                                  _textNumberController.value.text,
                                ),
                              ),
                            );
                          },
                          child: Icon(
                            Icons.save,
                            size: 26.0,
                          ),
                        ));
                    break;
                  default:
                    return Spacer();
                    break;
                }
              }),
            ],
          ),
          body: BlocBuilder<LoyaltyAddBloc, LoyaltyAddState>(
            builder: (_, state) {
              switch (state.runtimeType) {
                case LoyaltyAddAdding:
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Loyalty card name",
                              style: new TextStyle(
                                  color: Colors.black87, fontSize: 14.0),
                            ),
                            TextField(
                              controller: _textNameController,
                              style: new TextStyle(
                                  color: Colors.black87, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "Loyalty card number",
                              style: new TextStyle(
                                  color: Colors.black87, fontSize: 14.0),
                            ),
                            TextField(
                              controller: _textNumberController,
                              style: new TextStyle(
                                  color: Colors.black87, fontSize: 14.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  break;
                case LoyaltyAddSaving:
                  return Center(child: CircularProgressIndicator());
                  break;
                case LoyaltyAddError:
                  return _ErrorWidget();
                  break;
                case LoyaltyAddSaved:
                  return _SavedWidget();
                  break;
                default:
                  return _ErrorWidget();
              }
            },
          ),
        ));
  }
}

class _SavedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(),
          Text("The loyalty card has been saved."),
          ElevatedButton(
              child: Text("Done"),
              onPressed: () {
                BlocProvider.of<LoyaltyAddBloc>(context).add(Reset());
                BlocProvider.of<NavigatorBloc>(context).add(
                  NavigatorEventPop(),
                );
              }),
          Spacer(),
        ],
      ),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("An error has ocurred");
  }
}
