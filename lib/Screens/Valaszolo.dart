import 'package:flutter/material.dart';
import 'dart:math';
import 'package:loginmodule/Screens/AnswerCorrect.dart';
import 'package:loginmodule/Screens/InClassroom.dart';

bool JoValasz(String pressed, String correct) {
  if (pressed == correct) {
    return true;
  } else {
    return false;
  }
}

List<dynamic> answers = [];
int x = -1;

class Valaszolo extends StatelessWidget {
  List<dynamic> question;
  List<dynamic> correctAns;
  List<dynamic> ros1;
  List<dynamic> ros2;
  List<dynamic> ros3;
  List<dynamic> answers = [];

  Valaszolo(
    this.question,
    this.correctAns,
    this.ros1,
    this.ros2,
    this.ros3,
  );


  @override
  Widget build(BuildContext context) {
    if (x < ros1.length - 1) {
      x++;
      answers = [];
      answers.add(ros1[x]);
      answers.add(ros2[x]);
      answers.add(ros3[x]);
      answers.add(correctAns[x]);
      answers.shuffle();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => InClassRoom()));
    }

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.lightBlueAccent,
        child: Center(
          child: Container(
            color: Colors.lightBlueAccent,
            width: 420,
            height: 500,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    question[x],
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 175,
                        height: 175,
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnswerCorrect(
                                        JoValasz(
                                            answers[0], correctAns[x]))),
                              );
                            },
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              answers[0],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 175,
                        height: 175,
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnswerCorrect(
                                        JoValasz(
                                            answers[1], correctAns[x]))),
                              );
                            },
                            color: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              answers[1],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        width: 175,
                        height: 175,
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnswerCorrect(
                                        JoValasz(
                                            answers[2], correctAns[x]))),
                              );
                            },
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              answers[2],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 175,
                        height: 175,
                        child: Material(
                          elevation: 10.0,
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AnswerCorrect(
                                        JoValasz(
                                            answers[3], correctAns[x]))),
                              );
                            },
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              answers[3],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
