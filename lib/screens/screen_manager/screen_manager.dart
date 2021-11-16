import 'package:flutter/material.dart';
import 'package:gigi_notes/screens/notes_screen/notes_home_screen.dart';
import 'package:gigi_notes/screens/tasks_screen/tasks_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScreenManager extends StatefulWidget {
  const ScreenManager({Key? key}) : super(key: key);

  @override
  _ScreenManagerState createState() => _ScreenManagerState();
}

class _ScreenManagerState extends State<ScreenManager> {
  int _selectedIndex = 0;
  List<Widget> pageList = <Widget>[];
  static const String prefSelectedIndexKey = 'selectedIndex';

  @override
  void initState() {
    super.initState();
    pageList.add(const NotesHomeScreen());
    pageList.add(const TasksScreen());
    getCurrentIndex();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    saveCurrentIndex();
  }

  void saveCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    
    prefs.setInt(prefSelectedIndexKey, _selectedIndex);
  }

  void getCurrentIndex() async {
    final prefs = await SharedPreferences.getInstance();
    
    if (prefs.containsKey(prefSelectedIndexKey)) {
      setState(() {
        final index = prefs.getInt(prefSelectedIndexKey);
        if (index != null) {
          _selectedIndex = index;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: pageList),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 22,
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).bottomAppBarColor,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.book, color: _selectedIndex == 0 ? Theme.of(context).bottomAppBarColor : Theme.of(context).splashColor),
            label: 'Notes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task, color: _selectedIndex == 1 ? Theme.of(context).bottomAppBarColor : Theme.of(context).splashColor),
            label: 'Tasks',
          ),
        ],
      ),
    );
  }
}
