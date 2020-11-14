import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'adminHome.dart';

void main() => runApp(MaterialApp(
  routes: {
    '/':(context)=> AdminLogin(),
    '/ahome':(context)=>AdminHome()
  }
));

class AdminLogin extends StatefulWidget {
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {

  final adminEmail=TextEditingController();
  String nameError;
  final password=TextEditingController();
  bool seePassword=true;
  String passwordError;

  bool btnlogin=false;
  bool nextPage=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // backgroundColor: Colors.grey[300],
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover
            )
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20.0),
                margin: EdgeInsets.fromLTRB(0.0, 70.0, 0, 10),
                alignment: Alignment.center,
                child: Text(
                  'Admin Sign In',
                  style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 40.0,
                      color: Colors.black,
                      letterSpacing:1.5,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 50.0,),
                  Row(
                    children: [
                      Expanded(child: Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 10, 0),
                        child: Divider(
                          height: 1.5,
                          color: Colors.grey[400],
                        ),
                      )),
                      Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'Lato-Regular',
                          fontSize: 15.0,
                          color: Colors.grey[800],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Expanded(child: Container(
                        margin: EdgeInsets.fromLTRB(10, 0, 20, 0),
                        child: Divider(
                          height: 1.5,
                          color: Colors.grey[400],
                        ),
                      ))
                    ],
                  ),
                  SizedBox(height: 50.0,),
                  Container( //USERNAME
                    margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                    child: TextFormField(
                      controller: adminEmail,
                      showCursor: true,
                      decoration: new InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          errorText: nameError,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo, width: 2),
                          ),
                          suffixIcon: Icon(Icons.account_circle_rounded),
                          errorBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red[600])
                          ),
                          hintText: 'Email',
                          hintStyle: TextStyle(
                              color: Colors.grey[500]
                          )
                      ),
                    ),
                  ),
                  Divider(height: 20.0, indent: 10, endIndent: 10, color: Colors.grey),
                  Container( //PASSWORD
                    margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                    child: TextFormField(
                      controller: password,
                      showCursor: true,
                      decoration: new InputDecoration(
                          fillColor: Colors.white60,
                          filled: true,
                          errorText: passwordError,
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.indigo, width: 2),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(seePassword?Icons.remove_red_eye:Icons.security),
                            onPressed: (){
                              setState(() {
                                seePassword=!seePassword;
                              });
                            },
                          ),
                          hintText: 'Password',
                          hintStyle: TextStyle(
                              color: Colors.grey[500]
                          )
                      ),
                      obscureText: seePassword,
                    ),
                  ),
                  Divider(height: 20, indent: 10, endIndent: 10, color: Colors.grey),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                width: 200,
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      btnlogin=true;
                      if(adminEmail.text.length>0){
                        nameError=null;
                        if(password.text.length>0){
                          adminSignIn();
                        }
                        else{passwordError='Field must not be left empty';}
                      }
                      else{
                        nameError='Field must not be left empty';
                      }
                    });
                  },
                  color: btnlogin?Colors.indigo[600]:Colors.indigo[400],
                  highlightColor: Colors.indigo[600],
                  padding: EdgeInsets.fromLTRB(30.0, 15, 30.0, 15),
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                        fontFamily: 'Archivo',
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.0
                    ),
                  ),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)
                  ),
                ),
              ),
              SizedBox(height: 220,),
            ],
          ),
        ),
      ),
    );
  }
  Future adminSignIn() async{
    var url='https://filaceous-worksheet.000webhostapp.com/adminLogin.php';
    var data={
      "email":adminEmail.text,
      "password":password.text
    };
    var res= await http.post(url,body: data);
    if(json.decode(res.body).toString().contains("true")){
      Fluttertoast.showToast(msg: 'Welcome',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,);
      nextPage=true;
      var a=json.decode(res.body).toString().substring(4);
      if(nextPage){Navigator.pushReplacementNamed(context, '/ahome',arguments: {'condo':a});}
    }
    else if(json.decode(res.body)=="false"){
      Fluttertoast.showToast(msg: 'Invalid password input',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,);
    }
    else if(json.decode(res.body)=="no email"){
      Fluttertoast.showToast(msg: 'Invalid email input',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,);
    }
    else{
      Fluttertoast.showToast(msg: 'Error logging in',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,);
    }
  }
}
