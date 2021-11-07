import 'package:flutter/material.dart';
import 'note_item.dart';

class NoteManager extends ChangeNotifier {
  final _noteItems = <NoteItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;

  List<NoteItem> get noteItems => List.unmodifiable(_noteItems);

  int get selectedIndex => _selectedIndex;
  NoteItem? get selectedNoteItem => _selectedIndex != -1 ? _noteItems[_selectedIndex] : null;
  bool get isCreatingNewItem => _createNewItem;

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