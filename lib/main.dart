import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loginmodule/Screens/AnswerCorrect.dart';
import 'package:loginmodule/Screens/GoogleSignUp.dart';
import 'package:loginmodule/Screens/InClassroom.dart';
import 'package:loginmodule/Screens/KahootQuestion.dart';
import 'package:loginmodule/Screens/Classrooms.dart';
import 'package:loginmodule/Screens/Valaszolo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  .then((_){
  runApp(
    MaterialApp(title: 'Gyakorlapp', home: ScrollableClassroom())
  );});
}
