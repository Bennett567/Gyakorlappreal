import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loginmodule/Screens/Valaszolo.dart';

import 'package:loginmodule/Services/Auth.dart';
import 'package:loginmodule/Screens/GoogleSignUp.dart';
import 'globals.dart';
import 'InClassroom.dart';

var data = new Map<String, dynamic>();
var code;
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

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
  GlobalKey<RefreshIndicatorState> refreshKey;

  Future<String> createPopup(BuildContext context) {
    TextEditingController myController = TextEditingController();
    TextEditingController Controller = TextEditingController();
    getcode();
    return showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(100)),
            ),
            child: AlertDialog(
              title: Text('Osztály létrehozása'),
              content: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                margin: EdgeInsets.all(20),
                height: 100,
                width: 250,
                child: Column(
                  children: <Widget>[
                    TextField(
                      controller: myController,
                      decoration: InputDecoration(hintText: "Név"),
                    ),
                    TextField(
                        controller: Controller,
                        decoration: InputDecoration(hintText: "Jelszó"))
                  ],
                ),
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Létrehozás'),
                  onPressed: () {
                    pressre(myController, context, Controller);
                  },
                )
              ],
            ),
          );
        });
  }


  void pressre(TextEditingController myController, BuildContext context,
      TextEditingController Controller) async {
    if (myController.text.toString() != '') {
      await Firestore.instance.collection("classrooms").document().setData({
        "Name": myController.text.toString(),
        'Code': code + 1,
        "Jelszo": Controller.text.toString(),
      });
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
    refreshKey = GlobalKey<RefreshIndicatorState>();

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
    names.clear();
    nevek.clear();
    AIDS.clear();
    var y;
    QuerySnapshot snapshot = await databaseReference
        .orderBy('Code', descending: false)
        .getDocuments();

    snapshot.documents.forEach((f) {
      AIDS.add(f.documentID);
      y = (f.data.length);
      names.addAll(f.data);
      for (int i = 0; i < names.values
          .toList()
          .length / y; i++) {
        nevek.add(names.values.toList()[i + 2]);
      }
    });
    setState(() {});
  }

  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Text("Osztályok"),
            leading: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: IconButton(
                    icon: Icon(Icons.exit_to_app, color: Colors.white70),
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
                              color: Colors.white70),
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
          body: RefreshIndicator(
            key: refreshKey,
            onRefresh: () async{
              nevek.clear();
              AIDS.clear();

              await getclasses();
            },
            child: Builder(
                builder: (BuildContext context) {
                  return SnackBarPage(nevek, AIDS);
                }

            ),
          ),
        ));
  }
}

class SnackBarPage extends StatelessWidget {

  void jelszopress(TextEditingController jelszoController,
      BuildContext context) async {
    var jelszo;
    DocumentReference docRef = Firestore.instance.collection('classrooms')
        .document(globals.getid());
    await docRef.get().then((value) => jelszo = (value.data['Jelszo']));
    if (jelszo == jelszoController.text.toString()) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => InClassRoom()));
    }
    else {

      Navigator.pop(context);

      final snackBar = SnackBar(content: Text('Helytelen jelszó'));

      _scaffoldKey.currentState.showSnackBar(snackBar);
    }
  }


  Future<String> jelszobasz(BuildContext context) {
    TextEditingController jelszoController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Add meg a jelszót'),
              content: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: TextField(
                      controller: jelszoController,
                      decoration: InputDecoration(hintText: "Jelszó")
                  )
              ),
              actions: <Widget>[
                MaterialButton(
                  elevation: 5.0,
                  child: Text('Mehet'),
                  onPressed: () {
                    jelszopress(jelszoController, context);
                  },
                )
              ]);
        }
    );
  }

  var nevek;
  var AIDS;

  SnackBarPage(this.nevek, this.AIDS);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: nevek.length,
      itemBuilder: (context, index) {
        return
          Builder(
              builder: (BuildContext context) {
                return Card(
                  child: ListTile(
                    onTap: () {
                      globals.setid(AIDS[index]);
                      jelszobasz(context);
                    },
                    title: Text(nevek[index]),
                  )
                  ,
                );

              }
          );
      },
    );
  }
}