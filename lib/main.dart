import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:loyalty/domain/loyalty/loyalty_bloc.dart';
import 'package:loyalty/domain/navigator/navigator_bloc.dart';
import 'package:loyalty/presentation/loyalty/add/loyalty_add_page.dart';
import 'package:loyalty/presentation/loyalty/loyalty_list_page.dart';
import 'package:path_provider/path_provider.dart';

Future<void> _initialiseHive() async {
  final Directory appDocDirectory = await getApplicationDocumentsDirectory();
  final path = appDocDirectory.path;
  Hive
    ..init(path)
    ..registerAdapter(LoyaltyCardAdapter());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _initialiseHive();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NavigatorBloc>(
          create: (BuildContext context) =>
              NavigatorBloc(navigatorKey: _navigatorKey),
        ),
        BlocProvider<LoyaltyBloc>(
          create: (BuildContext context) => LoyaltyBloc(
              loyaltyCardRepository: LoyaltyCardRepository(LoyaltyCardBox())),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/home',
        navigatorKey: _navigatorKey,
        routes: {
          '/home': (context) => LoyaltyListPage(),
          '/add': (context) => LoyaltyAddPage(),
        },
      ),
    );
  }
}
