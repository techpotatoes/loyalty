import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loyalty/data/hive/loyaltycardbox.dart';
import 'package:loyalty/data/loyaltycard/model/loyaltycard.dart';
import 'package:loyalty/data/loyaltycard/repo/loyaltycardrepo.dart';
import 'package:loyalty/domain/loyalty/loyalty_bloc.dart';
import 'package:loyalty/presentation/loyalty/loyalty_list_page.dart';

void initialiseHive() async {
  var path = Directory.current.path;
  Hive
    ..init(path)
    ..registerAdapter(LoyaltyCardAdapter());

  //Warm up boxes
  await Hive.openBox<LoyaltyCard>('loyalty_card');
}

void main() async {
  initialiseHive();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (BuildContext context) => LoyaltyBloc(loyaltyCardRepository: LoyaltyCardRepository(LoyaltyCardBox())),
        child: LoyaltyListPage(),
      ));      
  }
}