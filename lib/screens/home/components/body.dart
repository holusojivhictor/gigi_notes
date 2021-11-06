import 'package:flutter/material.dart';
import 'package:gigi_notes/models/note_manager.dart';
import 'package:gigi_notes/screens/note_list/note_list_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NoteManager>(
      builder: (context, manager, child) {
        return NoteListScreen(manager: manager);
      },
    );
  }
}
