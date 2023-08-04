import 'package:hive01/Notes/hive/boxes.dart';
import 'package:hive_flutter/hive_flutter.dart';

class hiveHelper {
  static List<String> notes = [];

//add
  static void add(String title) async {
    notes.add(title);
    await Hive.box(noteBox).put(noteBox, notes);
  }

  //remove
  static void remove(int index) async {
    notes.removeAt(index);
    await Hive.box(noteBox).put(noteBox, notes);
  }

  static void getnote(void Function() refresh ) async {
    Future.delayed(Duration(seconds: 3));
    notes = await Hive.box(noteBox).get(noteBox);
    refresh();
  }

  //clear all notes

  static void clearallnotes(void Function() refresh ) async {
    notes=[];
    await Hive.box(noteBox).clear();
    refresh();
  }
  //update

  static void update(int index,String newtitle) async {
    notes[index]=newtitle;
    await Hive.box(noteBox).put(noteBox, notes);
  }

}