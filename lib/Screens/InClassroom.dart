import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginmodule/Screens/KahootQuestion.dart';
import 'package:loginmodule/Screens/globals.dart';
import 'package:rxdart/rxdart.dart';

import 'Valaszolo.dart';

var data = new Map<String, dynamic>();

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
      //print(adatok);
    }
  });
}

class InClassRoom extends StatefulWidget {
  @override
  _InClassRoomState createState() => _InClassRoomState();
}

class _InClassRoomState extends State<InClassRoom> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                icon: Icon(Icons.add_circle_outline),
                color: Colors.white70,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => KahootQuestion()));
                })),
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: IconButton(
                  icon: Icon(Icons.play_arrow),
                  color: Colors.white70,
                  onPressed: () async {
                    await getData();

                    int x = 0;
                    print(adatok);
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

                    print(ros1);
                    print(ros2);
                    print(ros3);
                    print(quest);
                    print(jo);

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
                  }))
        ],
      ),
    );
  }
}
