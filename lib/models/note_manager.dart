import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'note_item.dart';

class NoteManager extends ChangeNotifier {
  List<NoteItem> _noteItems = <NoteItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;

  List<NoteItem> get noteItems => List.unmodifiable(_noteItems);

  int get selectedIndex => _selectedIndex;
  NoteItem? get selectedNoteItem => _selectedIndex != -1 ? _noteItems[_selectedIndex] : null;
  bool get isCreatingNewItem => _createNewItem;
  static const String prefNoteKey = 'notesKey';


  void saveOldNotes() async {
    final prefs = await SharedPreferences.getInstance();

    String encodedData = NoteItem.encode(_noteItems);

    prefs.setString(prefNoteKey, encodedData);
  }

  void getOldNotes() async {
    final prefs = await SharedPreferences.getInstance();

    final oldNotes = prefs.getString(prefNoteKey);

    if (oldNotes != null) {
      List<NoteItem> noteItemSaved = NoteItem.decode(oldNotes);

      _noteItems = noteItemSaved;
    }
  }

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void deleteItem(int index) {
    _noteItems.removeAt(index);
    notifyListeners();
  }

  void noteItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedNoteItem(String id) {
    final index = noteItems.indexWhere((element) => element.cNoteId == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void addItem(NoteItem item) {
    _noteItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(NoteItem item, int index) {
    _noteItems[index] = item;
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _noteItems[index];
    _noteItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}