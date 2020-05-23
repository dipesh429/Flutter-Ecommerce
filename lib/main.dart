import 'package:cart/Screen/ProductScreen.dart';
import 'package:flutter/material.dart';

import './Screen/HomeScreen.dart';
import 'Screen/ProductAdd.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShopMandu',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.green
      ),
      routes: {
        '/':(ctx)=>HomeScreen(),
        ProductAdd.route:(ctx)=>ProductAdd(),
        ProductScreen.route:(ctx)=>ProductScreen()
      },
    );
  }
}


