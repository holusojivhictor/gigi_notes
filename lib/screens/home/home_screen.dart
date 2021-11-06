import 'package:flutter/material.dart';
import 'package:gigi_notes/models/note_manager.dart';
import 'package:gigi_notes/models/profile_manager.dart';
import 'package:gigi_notes/models/user.dart';
import 'package:gigi_notes/screens/home/components/body.dart';
import 'package:gigi_notes/screens/note_items/note_item_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String prefSelectedModeKey = 'selectedMode';
  bool isSwitched = false;

  @override
  void initState() {
    super.initState();
    // getSwitchValues();
  }

  getSwitchValues() async {
    isSwitched = (await getSwitchState())!;
    setState(() {});
  }

  Future<bool> saveSwitchState(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    prefs.setBool(prefSelectedModeKey, value);
    print('Switch value saved $value');
    return prefs.setBool(prefSelectedModeKey, value);
  }

  Future<bool?> getSwitchState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool? isSwitched = prefs.getBool(prefSelectedModeKey);
    print(isSwitched);

    return isSwitched;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gigi Notes'),
        actions: [
          themeSwitch(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.edit),
        onPressed: () {
          // Create a new note
          final manager = Provider.of<NoteManager>(context, listen: false);
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NoteItemScreen(
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
        value: widget.user.darkMode,
        onChanged: (value) {
          Provider.of<ProfileManager>(context, listen: false).darkMode = value;
        },
      ),
    );
  }
}
