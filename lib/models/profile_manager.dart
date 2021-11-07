import 'package:flutter/material.dart';
import 'user.dart';

class ProfileManager extends ChangeNotifier {
  User get getUser => User(
    darkMode: _darkMode,
  );

  bool get darkMode => _darkMode;

  var _darkMode = false;

  set darkMode(bool darkMode) {
    _darkMode = darkMode;
    notifyListeners();
  }
}

/*void saveData() async {
    final noteItems = widget.manager!.noteItems;

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final String encodedData = NoteItem.encode(noteItems);

    await prefs.setString('notesKey', encodedData);

    final String? noteString = prefs.getString('notesKey');

    final List<NoteItem> noteItemSaved = NoteItem.decode(noteString!);
  }*/
