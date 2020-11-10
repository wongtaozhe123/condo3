import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
  home: Loading(),
  // routes: {
  //   '/':(context) => Home()
  // },
));

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'LOADING',
          style: TextStyle(
            fontSize: 40,
            letterSpacing: 3,
          ),
        ),
      )
    );
  }
}
