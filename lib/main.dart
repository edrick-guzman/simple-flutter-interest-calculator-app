import "package:flutter/material.dart";

import 'app_screens/favorite_city.dart';
import 'app_screens/interest_calculator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Calculator",
      home: InterestCalculator(),
      theme: ThemeData(
        primaryColor: Colors.blue,
        accentColor: Colors.indigo
      ),
    );
  }

}