import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive01/Notes/hive/boxes.dart';
import 'package:hive01/Notes/note_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox(noteBox);

  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: noteScreen(),
    );
  }
}

