import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'task_item.dart';

class TaskManager extends ChangeNotifier {
  List<TaskItem> _taskItems = <TaskItem>[];
  int _selectedIndex = -1;
  bool _createNewItem = false;

  List<TaskItem> get taskItems => List.unmodifiable(_taskItems);

  int get selectedIndex => _selectedIndex;
  TaskItem? get selectedTaskItem => _selectedIndex != -1 ? _taskItems[_selectedIndex] : null;
  bool get isCreatingNewItem => _createNewItem;
  static const String prefTaskKey = 'tasksKey';

  void saveOldTasks() async {
    final prefs = await SharedPreferences.getInstance();

    String encodedData = TaskItem.encode(_taskItems);

    prefs.setString(prefTaskKey, encodedData);
  }

  void getOldTasks() async {
    final prefs = await SharedPreferences.getInstance();

    final oldTasks = prefs.getString(prefTaskKey);

    if (oldTasks != null) {
      List<TaskItem> taskItemSaved = TaskItem.decode(oldTasks);

      _taskItems = taskItemSaved;
    }
  }

  void createNewItem() {
    _createNewItem = true;
    notifyListeners();
  }

  void deleteItem(int index) {
    _taskItems.removeAt(index);
    notifyListeners();
  }

  void taskItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedTaskItem(String id) {
    final index = taskItems.indexWhere((element) => element.cTaskId == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void addItem(TaskItem item) {
    _taskItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(TaskItem item, int index) {
    _taskItems[index] = item;
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _taskItems[index];
    _taskItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
}