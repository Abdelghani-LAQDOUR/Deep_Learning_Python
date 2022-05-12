import 'package:fice_id/pages/Login.dart';
import 'package:fice_id/pages/homePage.dart';
import 'package:flutter/material.dart';



void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mnist',
      debugShowCheckedModeBanner: false,
      initialRoute: "/login",
      routes: <String, WidgetBuilder>{
        "/login": (BuildContext context) {
          return LoginPage();
        },
        "/home": (BuildContext context) {
          return HomePage();
        },
      },
    );
  }
}