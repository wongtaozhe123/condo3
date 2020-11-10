import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';
import 'package:user_login/MySqlRegistration.dart';

void main() => runApp(MaterialApp(
  home: Register(),
));

MyApp(){}

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final name=TextEditingController();
  String nameError;
  final password=TextEditingController();
  bool seePassword=true;
  String passwordError;
  final confirmPassword=TextEditingController();
  bool seeConfirmPassword=true;
  String confirmPasswordError;
  final contact=TextEditingController();
  String contactError;
  final email=TextEditingController();
  String emailError;
  final condo=TextEditingController();
  String condoError;
  final address=TextEditingController();
  String addressError;

  var db=new MySqlRegistration();

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
                alignment: Alignment.topLeft,
                child: Text(
                  'Welcome !',
                  style: TextStyle(
                      fontFamily: 'Lobster',
                      fontSize: 40.0,
                      color: Colors.black,
                      letterSpacing:1.5,
                      fontStyle: FontStyle.italic
                  ),
                ),
              ),
              Divider(height: 50.0, color: Colors.grey[400],thickness: 0.5,indent: 30,endIndent: 30,),

              Card(
                color: Colors.white,
                shadowColor: Colors.white,
                margin: EdgeInsets.fromLTRB(30.0, 20.0, 30.0, 40.0),
                child: Column(
                  children: [
                    SizedBox(height: 10.0,),
                    Center(
                      child: Text(
                        'Create Account',
                        style: TextStyle(
                          fontFamily: 'Lato-Regular',
                          fontSize: 15.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0,),
                    Container( //USERNAME
                      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                      child: TextFormField(
                        controller: name,
                        showCursor: true,
                        decoration: new InputDecoration(
                            errorText: nameError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
                            ),
                            suffixIcon: Icon(Icons.account_circle_rounded),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red[600])
                            ),
                            labelText: 'Name',
                            hintText: 'Username',
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
                            errorText: passwordError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
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
                            labelText: 'Password',
                            hintStyle: TextStyle(
                                color: Colors.grey[500]
                            )
                        ),
                        obscureText: seePassword,
                      ),
                    ),
                    Divider(height: 0, indent: 10, endIndent: 10, color: Colors.grey),
                    Container( //Confirm PASSWORD
                      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                      child: TextFormField(
                        controller: confirmPassword,
                        showCursor: true,
                        decoration: new InputDecoration(
                            errorText: confirmPasswordError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(seeConfirmPassword?Icons.remove_red_eye:Icons.security),
                              onPressed: (){
                                setState(() {
                                  seeConfirmPassword=!seeConfirmPassword;
                                });
                              },
                            ),
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            hintStyle: TextStyle(
                                color: Colors.grey[500]
                            )
                        ),
                        obscureText: seeConfirmPassword,
                      ),
                    ),
                    Divider(height: 0, indent: 10, endIndent: 10, color: Colors.grey),
                    Container( //PHONE
                      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                      child: TextFormField(
                        controller: contact,
                        showCursor: true,
                        keyboardType: TextInputType.number,
                        decoration: new InputDecoration(
                            errorText: contactError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
                            ),
                            suffixIcon: Icon(Icons.phone),
                            hintText: 'Phone number',
                            labelText: 'Phone number',
                            hintStyle: TextStyle(
                                color: Colors.grey[500]
                            )
                        ),
                      ),
                    ),
                    Divider(height: 0, indent: 10, endIndent: 10, color: Colors.grey),
                    Container( //EMAIL
                      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                      child: TextFormField(
                        controller: email,
                        showCursor: true,
                        keyboardType: TextInputType.emailAddress,
                        decoration: new InputDecoration(
                            errorText: emailError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
                            ),
                            suffixIcon: Icon(Icons.email),
                            hintText: 'Email',
                            labelText: 'Email',
                            hintStyle: TextStyle(
                                color: Colors.grey[500]
                            )
                        ),
                      ),
                    ),
                    Divider(height: 0, indent: 10, endIndent: 10, color: Colors.grey),
                    Container( //CONDO
                      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                      child: TextFormField(
                        controller: condo,
                        showCursor: true,
                        decoration: new InputDecoration(
                            errorText: condoError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
                            ),
                            suffixIcon: Icon(Icons.home),
                            hintText: 'Condo',
                            labelText: 'Condo',
                            hintStyle: TextStyle(
                                color: Colors.grey[500]
                            )
                        ),
                      ),
                    ),
                    Divider(height: 0, indent: 10, endIndent: 10, color: Colors.grey),
                    Container( //ADDRESS
                      margin: EdgeInsets.fromLTRB(20.0, 10, 20.0, 2),
                      child: TextFormField(
                        controller: address,
                        showCursor: true,
                        keyboardType: TextInputType.streetAddress,
                        decoration: new InputDecoration(
                            errorText: addressError,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide(color: Colors.indigo[200]),
                            ),
                            suffixIcon: Icon(Icons.location_on),
                            hintText: 'Address',
                            labelText: 'Address',
                            hintStyle: TextStyle(
                                color: Colors.grey[500]
                            )
                        ),
                      ),
                    ),
                    Divider(height: 10.0, indent: 10, endIndent: 10, color: Colors.grey),

                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                width: 200,
                child: RaisedButton(

                  onPressed: (){
                    setState(() {
                      bool veracity=false;
                      RegExp rg=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      RegExp rgContact=RegExp(r'(^(?:[+01])?[0-9]{10,11}$)');
                      RegExp rgEmail=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
                      if(!veracity){
                        if(name==null){
                          nameError='Field cannot be empty';
                        }
                        else{
                          if(name.text.length<8){
                            nameError='Name is too short';
                          }
                          else{
                            nameError=null; //NAME IS CORRECT CHECK FOR PASSWORD
                            if(password==null){
                              passwordError='Field cannot be empty';
                            }
                            else{
                              if(password.text.length<8&&password.text.length>20){
                                passwordError='Password must be between 8 to 20 characters';
                              }
                              else{
                                if(rg.hasMatch(password.text)){
                                  passwordError=null;
                                  if(password.text==confirmPassword.text){ //PASSWORD AND CONFIRM PASSWORD IS CORRECT CHECK FOR PHONE NUMBER
                                    confirmPasswordError=null;
                                    if(contact!=null){
                                      if(rgContact.hasMatch(contact.text)){
                                        contactError=null;
                                        if(email.text!=null){ //EMAIL IS CORRECT
                                          if(rgEmail.hasMatch(email.text)){
                                            emailError=null;
                                            if(condo!=null){
                                              condoError=null;
                                              if(address!=null){
                                                veracity=true;
                                              }
                                              else{addressError='Field cannot be left empty';}
                                            }
                                            else{condoError='Field cannot be left empty';}
                                          }
                                          else{emailError='Please enter a valid email';}
                                        }
                                        else{emailError='Field cannot be left empty';}
                                      }
                                      else{
                                        contactError='Please enter a valid phone number';
                                      }
                                    }
                                    else{
                                      contactError='Field cannot be left empty';
                                    }
                                  }
                                  else{
                                    confirmPasswordError='This does not match your password';
                                  }
                                }
                                else{
                                  passwordError='Need an uppercase, a lowercase, a number, a special character';
                                }
                              }
                            }
                          }
                        }
                      }
                    });
                  },
                  color: Colors.indigo[400],
                  padding: EdgeInsets.fromLTRB(30.0, 15, 30.0, 15),
                  child: Text(
                    'REGISTER',
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
            ],
          ),
        ),
      ),
    );
  }
}
