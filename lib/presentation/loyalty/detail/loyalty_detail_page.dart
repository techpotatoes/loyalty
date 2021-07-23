import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loyalty/domain/loyalty/detail/loyalty_detail_bloc.dart';
import 'package:loyalty/domain/loyalty/detail/loyalty_detail_event.dart';
import 'package:loyalty/domain/loyalty/detail/loyalty_detail_state.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';
import 'package:loyalty/domain/navigator/navigator_event.dart';
import 'package:loyalty/presentation/loyalty/loyalty_detail_barcode_widget.dart';

class LoyaltyDetailPage extends StatefulWidget {
  LoyaltyDetailPage({Key key}) : super(key: key);

  @override
  _LoyaltyDetailPageState createState() => _LoyaltyDetailPageState();
}

class _LoyaltyDetailPageState extends State<LoyaltyDetailPage> {
  var args;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      setState(() {
        args = ModalRoute.of(context).settings.arguments;
      });
      BlocProvider.of<LoyaltyDetailBloc>(context).add(FetchDetail(args));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F6F6),
      appBar: AppBar(
        title: Text("Loyalty Card"),
        actions: <Widget>[
          BlocBuilder<LoyaltyDetailBloc, LoyaltyDetailState>(
              builder: (_, state) {
            switch (state.runtimeType) {
              case LoyaltyDetailLoaded:
                return Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<LoyaltyDetailBloc>(context).add(
                          DeleteDetail(
                              (state as LoyaltyDetailLoaded).loyaltyCard),
                        );
                      },
                      child: Icon(
                        Icons.delete,
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
      body: BlocBuilder<LoyaltyDetailBloc, LoyaltyDetailState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LoyaltyDetailInitial:
              return _EmptyWidget();
              break;
            case LoyaltyDetailLoading:
              return Center(child: CircularProgressIndicator());
              break;
            case LoyaltyDetailError:
              return _ErrorWidget();
              break;
            case LoyaltyDetailDeleted:
              return _DeletedWidget();
              break;
            case LoyaltyDetailLoaded:
              return Center(
                child: Column(
                  children: [
                    Spacer(),
                    Text(
                      (state as LoyaltyDetailLoaded).loyaltyCard.name,
                      style:
                          new TextStyle(color: Colors.black54, fontSize: 50.0),
                    ),
                    Spacer(),
                    LoyaltyDetailBarcodeWidget(
                        loyaltyCard:
                            (state as LoyaltyDetailLoaded).loyaltyCard),
                    Spacer(),
                  ],
                ),
              );
              break;
            default:
              return _ErrorWidget();
          }
        },
      ),
    );
  }
}

class _EmptyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("Item not found.");
  }
}

class _ErrorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text("An error has ocurred");
  }
}

class _DeletedWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Spacer(),
          Text("The loyalty card has been deleted."),
          ElevatedButton(
              child: Text("Done"),
              onPressed: () {
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
