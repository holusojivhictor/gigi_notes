import '../models/note_item.dart';

abstract class Repository {
  Future<List<NoteItem>> findAllNotes();

  Stream<List<NoteItem>> watchAllNotes();

  Future<int> insertNote(NoteItem noteItem);

  Future<void> deleteNote(NoteItem noteItem);

  Future init();

  void close();
}