import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../class/network.dart';
import 'dart:async';
import 'homePage.dart';

class loginPage extends StatefulWidget {
  loginPage({Key key}) : super(key: key);

  _loginPageState createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  // final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  var resultData;
  bool _saving = false;

  loginToServer() async {
    var usernameData = usernameController.text;
    var passwordData = passwordController.text;
    setState(() {
     _saving = true; 
    });

    // var usernameData = "admin";
    // var passwordData = "admin";

    FormData formData =
        new FormData.from({"username": usernameData, "password": passwordData});

    var result = await Api().loginApi(formData);
    // print(result);

    if (mounted) {
      if (result != null) {
        if (result != "failed") {
          // print("login sukses");
          setState(() {
           _saving = false; 
          });
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => homePage()),
          );
        } else {
          print("login gagal");
        }
      } else {
        print("ini error");
        print(result);
      }
    }

    // print("json data = $result");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //logo image
              Container(
                // color: Colors.red,
                width: 150.0,
                height: 150.0,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/ljaBlankLogo.png'),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.only(left: 50.0, right: 50.0, bottom: 30.0),
                child: Column(
                  children: <Widget>[
                    // field username
                    Container(
                      child: TextField(
                        controller: usernameController,
                        decoration: InputDecoration(labelText: "Username"),
                      ),
                    ),

                    //field password
                    Container(
                      child: TextField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(labelText: "Password"),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: FlatButton(
                  child: Container(
                    width: 250.0,
                    height: 50.0,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(56, 142, 60, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Text(
                      "Sign In",
                      style: TextStyle(color: Color.fromRGBO(255, 255, 255, 1)),
                    ),
                  ),
                  onPressed: () {
                    // print(usernameController.text);
                    // print(passwordController.text);
                    loginToServer();
                  },
                ),
              ),
            ],
          ),
        ),
        inAsyncCall: _saving,
      ),
    );
  }
}
