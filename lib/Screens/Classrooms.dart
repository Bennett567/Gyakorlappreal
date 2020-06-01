import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginmodule/Screens/Valaszolo.dart';

import 'package:loginmodule/Services/Auth.dart';
import 'package:loginmodule/Screens/GoogleSignUp.dart';
import 'globals.dart';
import 'InClassroom.dart';





class ScrollableClassroom extends StatefulWidget {
  @override
  _ScrollableClassroomState createState() => _ScrollableClassroomState();
}

class _ScrollableClassroomState extends State<ScrollableClassroom> {
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
    var y;
    QuerySnapshot snapshot = await databaseReference.getDocuments();

    snapshot.documents.forEach((f) {
      AIDS.add(f.documentID);
      y = (f.data.length);
      names.addAll(f.data);
      for (int i = 0; i < names.values.toList().length / y; i++) {
        nevek.add(names.values.toList()[i + 1]);

      }
    });
    setState(() {
    });
  }
  Widget build(BuildContext context) {
    print(nevek);
    print(AIDS);

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
                        onPressed: null),
                    IconButton(
                        icon: Icon(Icons.search, color: Colors.black38),
                        onPressed: null),
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
                  globals.setid( AIDS[index]);
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
