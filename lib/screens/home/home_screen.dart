import 'package:flutter/material.dart';
import 'package:gigi_notes/models/note_manager.dart';
import 'package:gigi_notes/models/profile_manager.dart';
import 'package:gigi_notes/models/user.dart';
import 'package:gigi_notes/screens/home/components/body.dart';
import 'package:gigi_notes/screens/note_items/note_item_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
        activeColor: Colors.grey,
        value: widget.user.darkMode,
        onChanged: (value) {
          Provider.of<ProfileManager>(context, listen: false).darkMode = value;
        },
      ),
    );
  }
}
