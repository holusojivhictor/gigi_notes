import 'package:flutter/material.dart';
import 'package:gigi_notes/models/note_manager.dart';
import 'package:gigi_notes/models/profile_manager.dart';
import 'package:gigi_notes/screens/item_screen/notes/note_item_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'components/body.dart';

class NotesHomeScreen extends StatefulWidget {
  const NotesHomeScreen({Key? key}) : super(key: key);

  @override
  State<NotesHomeScreen> createState() => _NotesHomeScreenState();
}

class _NotesHomeScreenState extends State<NotesHomeScreen> {
  static const String prefSelectedModeKey = 'selectedMode';
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    // getSwitchValues();
  }

  getSwitchValues() async {
    isSwitched = (await getSwitchState())!;
    setState(() {
      Provider.of<ProfileManager>(context, listen: false).darkMode = isSwitched;
    });
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setBool(prefSelectedModeKey, value);
    return prefs.setBool(prefSelectedModeKey, value);
  }

  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isSwitched = prefs.getBool(prefSelectedModeKey);

    return isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gigi Notes'),
        /*actions: [
          themeSwitch(),
        ],*/
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        child: const Icon(Icons.edit),
        onPressed: () {
          // Create a new note
          final manager = Provider.of<NoteManager>(context, listen: false);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoteItemScreen(
                manager: manager,
                onCreate: (item) {
                  manager.addItem(item);
                  Navigator.pop(context);
                  },
                onUpdate: (_) {},
              )),
          );
        },
      ),
      body: const Body(),
    );
  }

  Widget themeSwitch() {
    return Transform.scale(
      scale: 0.7,
      child: Switch(
        key: const Key("Switch"),
        activeColor: Colors.grey,
        value: isSwitched,
        onChanged: (value) {
          isSwitched = value;
          saveSwitchState(value);
          Provider.of<ProfileManager>(context, listen: false).darkMode = value;
        },
      ),
    );
  }
}
