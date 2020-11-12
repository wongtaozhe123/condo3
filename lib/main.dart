import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

GoogleSignIn _googleSignIn=GoogleSignIn(
  scopes: <String> [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]
);

void main() => runApp(MaterialApp(
  home: Home(),
  // routes: {
  //   '/':(context) => Home()
  // },
));

MyApp(){}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final memail=TextEditingController();
  String nameError;
  final password=TextEditingController();
  bool seePassword=true;
  String passwordError;

  bool btnlogin=false;

  // VARIABLES FOR GOOGLE LOGIN
  GoogleSignInAccount currentUser;

  // VARIABLES FOR FACEBOOK LOGIN
  final facebookLogin = FacebookLogin();
  Map facebookProfile;
  bool fbLogin = false;

  @override
  void initState(){
    super.initState();
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount account) {
      setState(() {
        currentUser=account;
      });
    });
    _googleSignIn.signInSilently(); 
  }

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
                  'Sign In',
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
                        'Login with',
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
                  SizedBox(height: 30.0,),
                  Container( //USERNAME
                    margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                    child: TextFormField(
                      controller: memail,
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
                  Divider(height: 0.0, indent: 10, endIndent: 10, color: Colors.grey),
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
                  Divider(height: 0, indent: 10, endIndent: 10, color: Colors.grey),
                ],
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 30, 20, 20),
                width: 200,
                child: RaisedButton(
                  onPressed: (){
                    setState(() {
                      btnlogin=!btnlogin;
                      if(memail.text!=null){
                        nameError=null;
                        if(password.text!=null){
                          manualSignin();
                        }
                        else{passwordError='Field must not be left empty';}
                      }
                      else{
                        nameError='Field must not be left empty';
                      }
                      manualSignin();
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
              Row(
                children: [
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(50, 0, 10, 0),
                    child: Divider(
                      height: 1.5,
                      color: Colors.grey[400],
                    ),
                  )),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontFamily: 'Lato-Regular',
                      fontSize: 12.0,
                      color: Colors.grey[800],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(child: Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 50, 0),
                    child: Divider(
                      height: 1.5,
                      color: Colors.grey[400],
                    ),
                  ))
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(25),
                      child: RaisedButton.icon(
                        onPressed: () {
                          if(currentUser==null){
                            googleSignIn();
                          }
                          else{
                            print('$currentUser.email, not null when press');
                          }
                        },
                        color: Colors.red,
                        icon: Icon(Icons.email_rounded),
                        label: Text('G-Mail'),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: RaisedButton.icon(
                        color: Colors.blue,
                        onPressed: () async{
                          if(!fbLogin){
                            final result = await facebookLogin.logIn();
                            print(result);
                            switch(result.status){
                              case FacebookLoginStatus.Success:
                                final token=result.accessToken.token;
                                final graphResponse=await http.get('https://graph.facebook.com/v2.12/me?fields=name,picture,email&access_token=$token');
                                final profile=json.decode(graphResponse.body);
                                print(profile['name']);
                                setState(() {
                                  facebookProfile=profile;
                                  fbLogin=true;
                                });
                                break;
                              case FacebookLoginStatus.Cancel:
                                setState(() {
                                  fbLogin=false;
                                });
                                break;
                              case FacebookLoginStatus.Error:
                                setState(() {
                                  fbLogin=false;
                                  Fluttertoast.showToast(msg: ErrorDescription(result.error.toString()).toString(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    backgroundColor: Colors.black,
                                    textColor: Colors.white,
                                  );
                                });
                            }
                          }
                          else{
                            print('login with facebook already');
                          }
                        },
                        icon: Icon(Icons.tag_faces),
                        label: Text('Facebook'),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 90,),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> googleSignIn() async{
      try{
        await _googleSignIn.signIn();
        print(currentUser);
      }catch(error){
        print(error.toString());
        setState(() {
          Fluttertoast.showToast(msg: error.toString(),
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.black,
            textColor: Colors.white,
          );
        });
      }
  }
  void googleSignOut(){
    _googleSignIn.disconnect();
  }
  void facebookLogOut() async{
    await facebookLogin.logOut();
    setState(() {
      fbLogin=false;
    });
  }
  void manualSignin()async {
    var url='https://filaceous-worksheet.000webhostapp.com/login.php';
    var data={
      "email":memail.text,
      "password":password.text
    };
    var res= await http.post(url,body: data);
    if(json.decode(res.body)=="true"){
      Fluttertoast.showToast(msg: 'Welcome',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black,
        textColor: Colors.white,);
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
