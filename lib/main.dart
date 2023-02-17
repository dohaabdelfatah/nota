import 'package:flutter/material.dart';
import 'package:nota/addnotes.dart';
import 'package:nota/home.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      routes: {
        "AddNotes" : (context) => AddNotes()},
    );
  }
}