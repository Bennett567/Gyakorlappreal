import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginmodule/Screens/Valaszolo.dart';

import 'package:loginmodule/Services/Auth.dart';
import 'package:loginmodule/Screens/GoogleSignUp.dart';
import 'globals.dart';
import 'InClassroom.dart';



var data = new Map<String, dynamic>();
var code;

class ScrollableClassroom extends StatefulWidget {
  @override
  _ScrollableClassroomState createState() => _ScrollableClassroomState();
}

Future<void> getcode() async {
  final databaseReference = Firestore.instance.collection("latestcode");

  QuerySnapshot snapshot = await databaseReference.getDocuments();

  snapshot.documents.forEach((f) {
    data.addAll(f.data);

    code = data.values.toList()[0];
  });
}

class _ScrollableClassroomState extends State<ScrollableClassroom> {
  Future<String> createPopup(BuildContext context) {
    TextEditingController myController = TextEditingController();
    getcode();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Mi legyen a neve?'),
            content: TextField(
              controller: myController,
            ),
            actions: <Widget>[
              MaterialButton(
                elevation: 5.0,
                child: Text('Létrehozás'),
                onPressed: () {
                  pressre(myController, context);
                },
              )
            ],
          );
        });
  }

  void pressre(TextEditingController myController, BuildContext context) async {
    if (myController.text.toString() != '') {
      await Firestore.instance
          .collection("classrooms")
          .document()
          .setData({"Name": myController.text.toString(), 'Code': code + 1});
    }
    await getcode();
    Firestore.instance
        .collection('latestcode')
        .document('zTLghFqVFTRKaxaploWe')
        .setData({'code': code + 1});
    Navigator.of(context).pop(myController.text.toString());
    await getclasses();

    globals.setid(AIDS[AIDS.length - 1]);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => InClassRoom()));
  }

  @override
  void initState() {
    super.initState();
    AIDS = [];
    names.clear();
    getclasses();
  }

  final databaseReference = Firestore.instance.collection("classrooms");
  bool hany = false;
  var names = new Map<String, dynamic>();
  List nevek = [];
  List AIDS = [];

  Future<void> getclasses() async {
    AIDS.clear();
    var y;
    QuerySnapshot snapshot = await databaseReference
        .orderBy('Code', descending: false)
        .getDocuments();

    snapshot.documents.forEach((f) {
      AIDS.add(f.documentID);
      y = (f.data.length);
      names.addAll(f.data);
      for (int i = 0; i < names.values.toList().length / y; i++) {
        nevek.add(names.values.toList()[i + 1]);
      }
    });
    setState(() {});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Osztályok"),
          leading: Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: IconButton(
                  icon: Icon(Icons.exit_to_app, color: Colors.black38),
                  onPressed: () {
                    authService.signOut();
                    authService.loggedIn = false;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => GoogleSignUp()));
                  })),
          actions: <Widget>[
            Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Row(
                  children: <Widget>[
                    IconButton(
                        icon: Icon(Icons.add_circle_outline,
                            color: Colors.black38),
                        onPressed: () {
                          createPopup(context);
                        }),
//                    IconButton(
//                        icon: Icon(Icons.search, color: Colors.black38),
//                        onPressed: null),
                  ],
                )),
          ],
        ),
        body: ListView.builder(
          itemCount: nevek.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  globals.setid(AIDS[index]);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => InClassRoom()));
                },
                title: Text(nevek[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
