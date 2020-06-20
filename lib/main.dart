import 'chat_screen.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'register.dart';

void main()
{
  runApp(new MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return new MaterialApp
      (
      title: "Blog App",
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
       //home:HomePage(),
      initialRoute: HomePage.id,
      routes: {
        HomePage.id:(context) => HomePage(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        ChatScreen.id:(context) => ChatScreen(),
      },
    );

//    return MaterialApp(
//      /* theme: ThemeData.dark().copyWith(
//        textTheme: TextTheme(
//          body1: TextStyle(color: Colors.black54),
//        ),
//      ),*/
//      initialRoute: HomePage.id,
//      routes: {
//        HomePage.id:(context) => HomePage(),
//        LoginScreen.id:(context) => LoginScreen(),
//        //RegisterScreen.id:(context) => RegisterScreen(),
//      },
//    );

  }
}