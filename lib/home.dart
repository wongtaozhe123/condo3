import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
  var name;
  @override
  void initState(){
    getData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Text(
          '$name',
          style: TextStyle(
            fontSize: 40,
            letterSpacing: 3,
          ),
        ),
      )
    );
  }

  Future getData() async{
    var url='https://filaceous-worksheet.000webhostapp.com/get.php';
    http.Response response=await http.get(url);
    print(jsonDecode(response.body.toString()));
    name=response.body.toString();
  }
}
