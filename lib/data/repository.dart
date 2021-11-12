import '../models/note_item.dart';
import '../models/task_item.dart';

abstract class Repository {
  Future<List<NoteItem>> findAllNotes();

  Future<List<TaskItem>> findAllTasks();

  Stream<List<NoteItem>> watchAllNotes();

  Stream<List<TaskItem>> watchAllTasks();

  Future<int> insertNote(NoteItem noteItem);

  Future<int> insertTask(TaskItem taskItem);

  Future<int> updateNote(NoteItem noteItem);

  Future<int> updateTask(TaskItem taskItem);

  Future<void> deleteNote(NoteItem noteItem);

  Future<void> deleteTask(TaskItem taskItem);

  Future init();

  void close();
}