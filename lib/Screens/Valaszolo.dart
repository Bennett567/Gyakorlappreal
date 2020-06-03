import 'dart:async';
import 'dart:io';

import 'globals.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:loginmodule/Screens/AnswerCorrect.dart';
import 'package:loginmodule/Screens/InClassroom.dart';
import 'package:path_provider/path_provider.dart';

bool JoValasz(String pressed, String correct) {
  if (pressed == correct) {
    return true;
  } else {
    return false;
  }
}

int x = -1;

class Valaszolo extends StatefulWidget {
  List<dynamic> question;
  List<dynamic> correctAns;
  List<dynamic> ros1;
  List<dynamic> ros2;
  List<dynamic> ros3;

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
  List<dynamic> answers = [];

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    debugPrint(directory.path);
    return directory.path;

  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${globals.getid()}.txt');
  }

  Future<File> writepontok() async {
    final file = await _localFile;


    // Write the file.
    return file.writeAsString('${globals.getpontok()}');
  }

  Future<String> readpontok() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();

      return (contents);
    } catch (e) {
      // If encountering an error, return 0.
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    if (x < widget.ros1.length - 1) {
      x++;
      answers = [];
      answers.add(widget.ros1[x]);
      answers.add(widget.ros2[x]);
      answers.add(widget.ros3[x]);
      answers.add(widget.correctAns[x]);
      answers.shuffle();
    } else {
      scheduleMicrotask(() {
        writepontok();
        globals.setpontok(0);
        answers = [];
        ros1 = [];
        x = -1;

        Navigator.push(
            context, MaterialPageRoute(builder: (context) => InClassRoom()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (answers.length == 0) {
      return Scaffold(body: Container());
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

                     Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        widget.question[x],
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,

                        ),


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
                                            answers[0], widget.correctAns[x]),
                                        widget.correctAns[x])),
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
                                            answers[1], widget.correctAns[x]),
                                        widget.correctAns[x])),
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
                                            answers[2], widget.correctAns[x]),
                                        widget.correctAns[x])),
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
                                            answers[3], widget.correctAns[x]),
                                        widget.correctAns[x])),
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
