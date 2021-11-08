import 'package:flutter/material.dart';

import 'package:gigi_notes/components/note_tile.dart';
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
  late Offset _tapDownPosition;
  // List<NoteItem> noteItems = [];

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
              final itemNote = noteItems[index];

              return GestureDetector(
                child: NoteTile(
                  key: Key(itemNote.cNoteId.toString()),
                  item: itemNote,
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
                          originalItem: itemNote,
                          onCreate: (_) {},
                          onUpdate: (item) {
                            widget.manager.updateItem(item, index);
                            repository.updateNote(item);
                            Navigator.pop(context);
                            },
                        )),
                  );
                },
                onTapDown: (TapDownDetails details){
                  _tapDownPosition = details.globalPosition;
                },
                onLongPress: () async {
                  final RenderObject? overlay = Overlay.of(context)!.context.findRenderObject();

                  await showMenu(
                    context: context,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    position: RelativeRect.fromLTRB(
                      _tapDownPosition.dx,
                      _tapDownPosition.dy,
                      overlay!.semanticBounds.width - _tapDownPosition.dx,
                      overlay.semanticBounds.height - _tapDownPosition.dy,
                    ),
                    items: [
                      const PopupMenuItem(
                        child: Icon(Icons.delete),
                        value: 'Delete',
                      ),
                    ],
                  ).then((value) {
                    if (value == 'Delete') {
                      deleteNote(repository, itemNote);
                    }
                  });
                },
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
