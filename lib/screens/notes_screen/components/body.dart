import 'package:flutter/material.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:gigi_notes/models/note_item.dart';
import 'package:gigi_notes/models/note_manager.dart';
import 'package:gigi_notes/screens/empty_screen/empty_note_screen.dart';
import 'package:gigi_notes/screens/lists_screen/notes/note_list_screen.dart';
import 'package:provider/provider.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);

    return StreamBuilder<List<NoteItem>>(
        stream: repository.watchAllNotes(),
        builder: (context, AsyncSnapshot<List<NoteItem>> snapshot) {
          final noteItems = snapshot.data ?? [];

          if (noteItems.isNotEmpty) {
            return Consumer<NoteManager>(
              builder: (context, manager, child) {
                return NoteListScreen(manager: manager);
              },
            );
          } else {
            return const EmptyNoteScreen();
          }
        });
  }
}
