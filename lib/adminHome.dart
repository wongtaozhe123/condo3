import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'adminLogin.dart';

void main()=> runApp(MaterialApp(
    routes: {
      '/':(context)=> AdminLogin(),
      '/ahome':(context)=>AdminHome()
    }
));

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('condo details'),
        centerTitle: true,
      ),
      body: Container(
        child: Container(
          child: FutureBuilder(
            future: getCondoList(),
            builder: (context, snapshot){
              if(snapshot.hasError){
                Fluttertoast.showToast(msg: snapshot.error.toString(),
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,);
              }
              return snapshot.hasData?ListView.builder(itemCount: snapshot.data.length ,itemBuilder: (context,index){
                List list=snapshot.data;
                return Column(
                  children: [
                    Container(
                      child: Text(list[index]['name']),
                    ),
                    Container(
                      child: Text(list[index]['email']),
                    ),
                    Container(
                      child: Text(list[index]['address']),
                    ),
                    Container(
                      child: Text(list[index]['contactNumber']),
                    ),
                    Divider(height: 20, indent: 10, endIndent: 10, color: Colors.grey),
                  ],
                );
              }):Center(child: CircularProgressIndicator(),);
            },
          ),
        ),
      ),
    );
  }
  Future getCondoList() async{
    Map cd=ModalRoute.of(context).settings.arguments;
    var condos=await cd['condo'];
    var url='http://filaceous-worksheet.000webhostapp.com/adminCondo.php';
    var data={
      "condos":condos
    };
    var res=await http.post(url, body: data);
    // print(json.decode(res.body));
    return json.decode(res.body);
  }
}