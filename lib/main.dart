import 'package:architecture_action_item/screens/HomeWithBloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyBlocApp());
}

class MyBlocApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeWithBloc(),
      debugShowCheckedModeBanner: false,
    );
  }
}
