import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:loginmodule/Screens/InClassroom.dart';
import 'package:loginmodule/Screens/KahootQuestion.dart';
import 'package:loginmodule/Screens/Classrooms.dart';
import 'package:loginmodule/Services/Auth.dart';
import 'package:loginmodule/Screens/Classrooms.dart';

class GoogleSignUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: Container(
          child: Column(children: <Widget>[
            Container(
              height: (MediaQuery.of(context).size.height) / 5,
              width: MediaQuery.of(context).size.width,
            ),
            Container(
              height: (MediaQuery.of(context).size.height) / 5,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image(
                      image: AssetImage(
                          'C:/Users/Dani/Desktop/gyakorlappreal/lib/UI/logo.png')),
                ),
//                  child: Text(
//                    "GyakorlApp",
//                    style: TextStyle(color: Colors.white, fontSize: 50),
              ),
            ),
            RaisedButton(
              onPressed: () async {
                await authService.testSignInWithGoogle();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScrollableClassroom()));
              },
              elevation: 20.0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        right: 15.0, top: 10.0, bottom: 10.0),
                    child: Icon(FontAwesomeIcons.google),
                  ),
                  Text(
                    "Bejelentkezés Google fiókkal",
                    style: TextStyle(fontSize: 15),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
