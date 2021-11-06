import 'package:flutter/material.dart';
import 'package:gigi_notes/constants.dart';
import 'package:gigi_notes/data/repository.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'package:gigi_notes/models/models.dart';

class NoteItemScreen extends StatefulWidget {
  final Function(NoteItem) onCreate;
  final Function(NoteItem) onUpdate;
  final NoteItem? originalItem;
  final bool isUpdating;

  const NoteItemScreen({
    Key? key,
    required this.onCreate,
    required this.onUpdate,
    this.originalItem,
  }) : isUpdating = (originalItem != null), super(key: key);

  @override
  _NoteItemScreenState createState() => _NoteItemScreenState();
}

class _NoteItemScreenState extends State<NoteItemScreen> {
  final _titleController =  TextEditingController();
  final _noteTextController = TextEditingController();
  String _title = '';
  String _noteText = '';
  final DateTime _editDate = DateTime.now();
  final TimeOfDay _timeOfDay = TimeOfDay.now();

  @override
  void initState() {
    final originalItem = widget.originalItem;
    if (originalItem != null) {
      _titleController.text = originalItem.title;
      _title = originalItem.title;
      _noteTextController.text = originalItem.noteText;
      _noteText = originalItem.noteText;
    }

    /*final date = originalItem!.date!;
    _timeOfDay = TimeOfDay(hour: date.hour, minute: date.minute);
    _editDate = date;*/

    _titleController.addListener(() {
      setState(() {
        _title = _titleController.text;
      });
    });

    _noteTextController.addListener(() {
      setState(() {
        _noteText = _noteTextController.text;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _noteTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = Provider.of<Repository>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: GestureDetector(
                      child: const Icon(Icons.arrow_back_ios_new, size: 19),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                  // build titleField
                  buildTitleField(),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.check),
                    onPressed: () {
                      final genDateTime = DateTime(
                        _editDate.year,
                        _editDate.month,
                        _editDate.day,
                        _timeOfDay.hour,
                        _timeOfDay.minute,
                      );

                      final noteItem = NoteItem(
                        cNoteId: widget.originalItem?.cNoteId ?? const Uuid().v1(),
                        title: _titleController.text,
                        noteText: _noteTextController.text,
                        dateTime: '',
                      );

                      if (widget.isUpdating) {
                        widget.onUpdate(noteItem);
                        repository.updateNote(noteItem);
                      } else {
                        widget.onCreate(noteItem);
                        repository.insertNote(noteItem);
                      }

                    },
                  ),
                ],
              ),
              const Divider(),
              buildNoteTextField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTitleField() {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: SizedBox(
        width: size.width * 0.7,
        height: 50,
        child: TextField(
          controller: _titleController,
          cursorHeight: 18,
          cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
          style: Theme.of(context).textTheme.headline2,
          decoration: const InputDecoration(
            hintText: 'Title',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNoteTextField() {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 600,
      width: size.width * 0.98,
      child: TextField(
        maxLines: 100,
        controller: _noteTextController,
        cursorHeight: 20,
        style: Theme.of(context).textTheme.headline6,
        cursorColor: Theme.of(context).textSelectionTheme.cursorColor,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          contentPadding: EdgeInsets.all(kPadding * 1.5),
        ),
      ),
    );
  }
}
