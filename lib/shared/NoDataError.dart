import 'package:flutter/material.dart';

class NoDataError extends StatelessWidget {
  final String text;

  const NoDataError({Key key, this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(

        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 2,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),


        ),
      ),
    );
  }
}
