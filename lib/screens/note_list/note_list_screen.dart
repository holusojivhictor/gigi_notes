import 'package:flutter/material.dart';

import 'package:gigi_notes/components/note_tile.dart';
import 'package:gigi_notes/components/popup_menu.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:gigi_notes/models/models.dart';
import 'package:gigi_notes/screens/empty_screen/empty_note_screen.dart';
import 'package:provider/provider.dart';
import '../note_items/note_item_screen.dart';

class NoteListScreen extends StatefulWidget {
  final NoteManager manager;
  const NoteListScreen({Key? key, required this.manager}) : super(key: key);

  @override
  State<NoteListScreen> createState() => _NoteListScreenState();
}

class _NoteListScreenState extends State<NoteListScreen> {
  List<NoteItem> noteItems = [];

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context, listen: false);
    // final noteItems = widget.manager.noteItems;

    return StreamBuilder<List<NoteItem>>(
      stream: repository.watchAllNotes(),
      builder: (context, AsyncSnapshot<List<NoteItem>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final noteItems = snapshot.data ?? [];

          return GridView.count(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            children: List.generate(noteItems.length, (index) {
              final item = noteItems[index];

              return GestureDetector(
                child: NoteTile(
                  key: Key(item.cNoteId.toString()),
                  item: item,
                  onComplete: (change) {
                    if (change != null) {
                      widget.manager.completeItem(index, change);
                    }
                  },
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NoteItemScreen(
                          originalItem: item,
                          onCreate: (_) {},
                          onUpdate: (item) {
                            widget.manager.updateItem(item, index);
                            Navigator.pop(context);
                            },
                        )),
                  );
                },
                /*onLongPress: () {
                  PopupMenuContainer<String>(
                    child: const Icon(Icons.delete),
                    items: const [
                      PopupMenuItem(value: 'delete', child: Text('Delete'))
                    ],
                    onItemSelected: (value) async {
                      if( value == 'delete' ){
                        deleteNote(repository, item);
                      }
                    },
                  );
                },*/
              );
            }),
          );
        } else {
          return const EmptyNoteScreen();
        }
      },
    );
  }

  void deleteNote(Repository repository, NoteItem noteItem) async {
    if (noteItem.cNoteId != null) {
      repository.deleteNote(noteItem);

      setState(() {});
    } else {
      // ignore: avoid_print
      print('Note id is null');
    }
  }
}
