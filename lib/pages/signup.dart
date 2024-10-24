import 'dart:core';
import 'dart:math';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/login.dart';
import 'package:food_delivery/service/database.dart';
import 'package:food_delivery/service/shared_pref.dart';
import 'package:food_delivery/widget/widget_support.dart';
import 'package:random_string/random_string.dart';

import 'bottomnav.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email = "";
  String password = "";
  String name = "";

  TextEditingController namecontroller = new TextEditingController();

  TextEditingController passwordcontroller = new TextEditingController();

  TextEditingController emailcontroller = new TextEditingController();

  final _formkey = GlobalKey<FormState>();

  registration() async {
    if(password !=null){

      try{

        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar((SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text("Registered Successfully", style: TextStyle(fontSize: 20),),)));    

           
           String Id = randomAlphaNumeric(10);
           
           Map<String, dynamic> addUserInfo = {
            "Name": namecontroller.text,
            "Email": emailcontroller.text,
            "Wallet":"0",
            "Id": Id,
           };
           await DatabaseMethods().addUserDetail(addUserInfo, Id);
           await SharedPrefHelper().saveUserName(namecontroller.text);
            await SharedPrefHelper().saveUserEmail(emailcontroller.text);
             await SharedPrefHelper().saveUserId(Id);
              await SharedPrefHelper().saveUserWallet('0');


        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> BottomNav()));

      }on FirebaseAuthException catch(e){
        if(e.code == 'weak-password'){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text("Password Provided is too Weak", style: TextStyle(fontSize: 18),),)));

        }

        else if(e.code=="email-already-in-use"){
          ScaffoldMessenger.of(context).showSnackBar((SnackBar(
            backgroundColor: Colors.orangeAccent,
            content:
            Text("Account Already exists",
              style: TextStyle(fontSize: 18),),)));
        }
      }

    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/2.5,
                  decoration: BoxDecoration(gradient: LinearGradient(

                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFff5c30),
                        Color(0xFFe74b1a),
                      ])),
                ),

                Container(
                  margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/3,),
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight: Radius.circular(40))),
                  child: Text(""),
                ),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  margin: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),

                  child: Column(
                    children: [
                      Center(child: Image.asset("images/logo.png",  width: MediaQuery.of(context).size.width/1.5, fit: BoxFit.cover,)),

                      SizedBox(height: 50.0,),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(

                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height/1.8,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(height: 30.0,),
                                Text("SignUp", style: AppWidget.HeaderlineTextFeildStyle()),

                                TextFormField(
                                  controller: namecontroller,
                                  validator:(value) {
                                    if(value==null || value.isEmpty){
                                      return 'Please Enter Name';
                                    }

                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Name', hintStyle: AppWidget.LightTextFeildStyle(), suffixIcon: Icon(Icons.person_2_outlined)
                                  ),
                                ),

                                SizedBox(height: 20.0,),

                                TextFormField(
                                  controller: emailcontroller,
                                  decoration: InputDecoration(
                                      hintText: 'E-mail', hintStyle: AppWidget.LightTextFeildStyle(), suffixIcon: Icon(Icons.email_outlined)
                                  ),
                                ),

                                SizedBox(height: 20.0,),

                                TextFormField(
                                  controller: passwordcontroller,
                                  validator:(value) {
                                    if(value==null || value.isEmpty){
                                      return 'Please Enter Password';
                                    }

                                    return null;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'Password', hintStyle: AppWidget.LightTextFeildStyle(), suffixIcon: Icon(Icons.password_outlined)
                                  ),
                                ),


                                SizedBox(height: 40,),

                                GestureDetector(

                                  onTap: () async{
                                    if(_formkey.currentState!.validate()){
                                      setState(() {
                                        email=emailcontroller.text;
                                        name=namecontroller.text;
                                        password=passwordcontroller.text;
                                      });
                                    }
                                    registration();
                                  },

                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding: EdgeInsets.symmetric(vertical: 15.0),
                                      width: 500,
                                      decoration: BoxDecoration(color: Color(0xffff5722), borderRadius: BorderRadius.circular(20)),

                                      child: Center(
                                          child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18.0, fontFamily:
                                            "Poopins",
                                                fontWeight: FontWeight.bold),)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 40.0,),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => LogIn()));
                          },
                          child: Text
                            ("Already have an account? Login",
                            style: AppWidget.semiBoldTextFeildStyle(),))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}