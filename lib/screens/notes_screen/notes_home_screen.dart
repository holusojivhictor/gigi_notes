import 'package:flutter/material.dart';
import 'package:gigi_notes/components/contact.dart';
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
  static const String prefSelectedModeKey = 'selectedAppMode';
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    getSwitchValues();
  }

  getSwitchValues() async {
    isSwitched = await getSwitchState();
    setState(() {
      Provider.of<ProfileManager>(context, listen: false).darkMode = isSwitched;
    });
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setBool(prefSelectedModeKey, value);
    return prefs.setBool(prefSelectedModeKey, value);
  }

  Future getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getBool(prefSelectedModeKey) == null ? false : (prefs.getBool(prefSelectedModeKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 40),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: themeSwitch(),
            ),
            ListTile(
              title: const Text('Contact'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ExtraPage()));
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        titleSpacing: 0,
        title: const Text('Gigi Notes'),
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
        key: const Key("SwitchMode"),
        activeColor: Colors.grey,
        value: isSwitched,
        onChanged: (value) {
          setState(() {
            isSwitched = value;
            saveSwitchState(value);
          });
          Provider.of<ProfileManager>(context, listen: false).darkMode = value;
        },
      ),
    );
  }
}
