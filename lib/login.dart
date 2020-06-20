import 'package:flutter/material.dart';
import 'package:learning_app/HomePage.dart';
import 'rounded_button.dart';
import 'constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'DialogBox.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {

  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  DialogBox dialogBox = new DialogBox();
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Login"),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Hero(
                tag:'logo',
                child: Container(
                  //child: Image.asset('images/logo.png'),
                  height: 100.0,
                ),
              ),
              SizedBox(
                height: 13.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email=value;
                },
                decoration: kMessageTextFieldDecoration.copyWith(hintText: 'Enter Your email'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password=value;
                },
                decoration: kMessageTextFieldDecoration.copyWith(hintText: 'Enter Your password'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Log In',
                colour: Colors.orange,
                onPressed: () async {
//                  print(email);
//                  print(password);
                  setState(() {
                    showSpinner=true;
                  });

                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if(user!=null)
                    {
                      Navigator.pushNamed(context, HomePage.id);
                    }
                   dialogBox. information(context,"Logged ","In successfully");
                    setState(() {
                      showSpinner=false;
                    });
                  }
                  catch(e)
                  {
                    dialogBox. information(context,"Error = ",e.toString());
                    print(e);
                  }

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
