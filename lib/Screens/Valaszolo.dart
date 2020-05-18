import 'package:flutter/material.dart';
import 'dart:math';
import 'package:loginmodule/Screens/AnswerCorrect.dart';

bool JoValasz(String pressed, String correct) {
  if (pressed == correct) {
    return true;
  } else {
    return false;
  }
}
List<dynamic> answers = [];


class Valaszolo extends StatefulWidget {
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
  _ValaszoloState createState() => _ValaszoloState();
}

class _ValaszoloState extends State<Valaszolo> {
  @override
  Widget build(BuildContext context) {
    answers.add(widget.ros1[0]);
    answers.add(widget.ros2[0]);
    answers.add(widget.ros3[0]);
    answers.add(widget.correctAns[0]);
    answers.shuffle();
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
                    widget.question[0],
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
                                        JoValasz(widget.answers[0],
                                            widget.correctAns[0]))),
                              );
                            },
                            color: Colors.greenAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              widget.answers[0],
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
                              /*Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => AnswerCorrect(JoValasz(widget.answers[1],
                                  widget.correctAns))),
                            );*/
                            },
                            color: Colors.yellowAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              widget.answers[1],
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
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AnswerCorrect(JoValasz(widget.answers[2],
                                    widget.correctAns))),
                              );*/
                            },
                            color: Colors.redAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              widget.answers[2],
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
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => AnswerCorrect(JoValasz(widget.answers[3],
                                    widget.correctAns))),
                              );*/
                            },
                            color: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Text(
                              widget.answers[3],
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
