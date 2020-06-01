import 'package:flutter/material.dart';
import 'package:loginmodule/Screens/InClassroom.dart';
import 'package:loginmodule/Screens/Valaszolo.dart';
import 'globals.dart';

String cw(correct) {
  String displayText;
  if (correct) {
    displayText = "Helyes!";
    globals.setpontok(globals.getpontok() + 1);
    return displayText;
  } else {
    displayText = "Nem jó válasz!";
    return displayText;
  }
}

Color bgColor(correct) {
  Color bgColor;
  if (correct) {
    bgColor = Colors.green;
    return bgColor;
  } else {
    bgColor = Colors.red;
    return bgColor;
  }
}

String text(correct, answer) {
  if (correct) {
    return "";
  }
  return "A helyes válasz: " + answer;
}

class AnswerCorrect extends StatefulWidget {
  bool correct;
  String ans;

  AnswerCorrect(this.correct, this.ans);

  @override
  _AnswerCorrectState createState() => _AnswerCorrectState();
}

class _AnswerCorrectState extends State<AnswerCorrect> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: bgColor(widget.correct),
          child: Center(
            child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      cw(widget.correct),
                      style: TextStyle(
                        fontSize: 75,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        text(widget.correct, widget.ans),
                        style: TextStyle(
                          fontSize: 30,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      Valaszolo(quest, jo, ros1, ros2, ros3)));
                        },
                        color: Colors.blueGrey,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Text(
                          "Következő kérdés",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
