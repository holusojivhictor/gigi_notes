import 'dart:async';
import 'package:gigi_notes/models/task_item.dart';

import '../repository.dart';
import 'database_helper.dart';
import 'package:gigi_notes/models/models.dart';

class SqliteRepository extends Repository {
  final dbHelper = DatabaseHelper.instance;

  @override
  Future<List<NoteItem>> findAllNotes() {
    return dbHelper.findAllNotes();
  }

  @override
  Future<List<TaskItem>> findAllTasks() {
    return dbHelper.findAllTasks();
  }

  @override
  Stream<List<NoteItem>> watchAllNotes() {
    return dbHelper.watchAllNotes();
  }

  @override
  Stream<List<TaskItem>> watchAllTasks() {
    return dbHelper.watchAllTasks();
  }

  @override
  Future<int> insertNote(NoteItem noteItem) {
    return Future(() async {
      final id = await dbHelper.insertNote(noteItem);

      return id;
    });
  }

  @override
  Future<int> insertTask(TaskItem taskItem) {
    return Future(() async {
      final id = await dbHelper.insertTask(taskItem);

      return id;
    });
  }

  @override
  Future<int> updateNote(NoteItem noteItem) {
    return Future(() async {
      final id = await dbHelper.updateNote(noteItem);

      return id;
    });
  }

  @override
  Future<int> updateTask(TaskItem taskItem) {
    return Future(() async {
      final id = await dbHelper.updateTask(taskItem);

      return id;
    });
  }

  @override
  Future<void> deleteNote(NoteItem noteItem) {
    dbHelper.deleteNote(noteItem);

    return Future.value();
  }

  @override
  Future<void> deleteTask(TaskItem taskItem) {
    dbHelper.deleteTask(taskItem);

    return Future.value();
  }

  @override
  Future init() async {
    await dbHelper.database;
    return Future.value();
  }

  @override
  void close() {
    dbHelper.close();
  }
}
