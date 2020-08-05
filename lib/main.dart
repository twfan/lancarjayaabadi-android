import 'package:flutter/material.dart';
import 'package:lancarjayaabadi/screenPage/loginPage.dart';
import './screenPage/loginPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
        primaryColor: Color.fromRGBO(56, 142, 60, 1),
        accentColor: Color.fromRGBO(75, 165, 41, 1),
      ),
      initialRoute: "/",
      routes: {
        "/":(_)=>loginPage(),
      },
    );
  }
}