import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginmodule/Screens/Classrooms.dart';
import 'package:loginmodule/Screens/KahootQuestion.dart';
import 'package:rxdart/rxdart.dart';
import 'globals.dart';
import 'Valaszolo.dart';
import 'package:path_provider/path_provider.dart';

var data = new Map<String, dynamic>();
String pontszam;

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
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

//Ebben tároljuk a Firestoreból érkező kérdéseket.
List adatok = [];
List quest = [];
List jo = [];
List ros1 = [];
List ros2 = [];
List ros3 = [];
String id;

String _title(BuildContext context, DocumentSnapshot snap) {
  return snap["Name"];
}

Future<void> getData() async {
  final databaseReference = Firestore.instance
      .collection("classrooms")
      .document(globals.getid())
      .collection("questions");

  adatok = [];
  QuerySnapshot snapshot = await databaseReference.getDocuments();
  adatok = [];
  quest = [];
  jo = [];
  ros1 = [];
  ros2 = [];
  ros3 = [];

  snapshot.documents.forEach((f) {
    data.addAll(f.data);
    for (int i = 0; i < data.values.toList().length; i++) {
      adatok.add(data.values.toList()[i]);
    }
  });
}

class InClassRoom extends StatefulWidget {
  @override
  _InClassRoomState createState() => _InClassRoomState();
}

class _InClassRoomState extends State<InClassRoom> {
  @override
  var pontsz;

  Future<String> readpontok() async {
    try {
      final file = await _localFile;

      // Read the file.
      String contents = await file.readAsString();
      setState(() {
        pontsz = contents;
      });
    } catch (e) {
      // If encountering an error, return 0.
      pontsz = "ERROR";
    }
  }

  void initState() {
    readpontok();
    super.initState();
  }

  Widget build(BuildContext context) {
    pontszam = readpontok().toString();

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: StreamBuilder(
            stream: Firestore.instance
                .collection("classrooms")
                .document(globals.getid())
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Text("Loading");
              }
              return Text(_title(context, snapshot.data));
            },
          ),
          leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: IconButton(
                  icon: Icon(Icons.keyboard_backspace),
                  color: Colors.white70,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScrollableClassroom()));
                  })),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(children: <Widget>[
                  IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      color: Colors.white70,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => KahootQuestion()));
                      }),
                  IconButton(
                      icon: Icon(Icons.play_arrow),
                      color: Colors.white70,
                      onPressed: () async {
                        await getData();

                        int x = 0;

                        for (int i = 0; i < adatok.length; i++) {
                          if (x == 0) {
                            ros1.add(adatok[i]);
                          }
                          if (x == 1) {
                            ros2.add(adatok[i]);
                          }
                          if (x == 2) {
                            ros3.add(adatok[i]);
                          }
                          if (x == 3) {
                            quest.add(adatok[i]);
                          }
                          if (x == 4) {
                            jo.add(adatok[i]);
                            x = 0;
                            continue;
                          }
                          x++;
                        }

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Valaszolo(
                                      quest,
                                      jo,
                                      ros1,
                                      ros2,
                                      ros3,
                                    )));
                      })
                ]))
          ],
        ),
        body: Center(
          child: Text(
            (pontsz != null)
                ? "A legutóbbi pontszámod: ${pontsz.toString()}."
                : "Még nem játszottad le.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 50,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
