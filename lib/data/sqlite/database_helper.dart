import 'package:gigi_notes/models/task_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:gigi_notes/models/models.dart';

class DatabaseHelper {
  static const _databaseName = 'GigiNotesUpdate.db';
  static const _databaseVersion = 1;

  static const noteTable = 'GigiNotes';
  static const noteId = 'noteId';
  static const cNoteId = 'cNoteId';

  static const taskTable = 'GigiTasks';
  static const taskId = 'taskId';
  static const cTaskId = 'cTaskId';

  static late BriteDatabase _streamDatabase;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

  static Database? _database;

  // SQL code to create the database tables

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $noteTable (
            $noteId INTEGER PRIMARY KEY,
            $cNoteId INTEGER,
            title TEXT,
            noteText TEXT,
            dateTime TEXT,
            isComplete INTEGER
          )
          ''');

    await db.execute('''
          CREATE TABLE $taskTable (
            $taskId INTEGER PRIMARY KEY,
            $cTaskId INTEGER,
            title TEXT,
            taskDescription TEXT,
            category TEXT,
            dateTime TEXT,
            isComplete INTEGER
          )
          ''');
  }

  // This opens the database (and creates it if it doesn't already exist)

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, _databaseName);

    // Remember to turn off debugging before deploying to app store(s)
    Sqflite.setDebugModeOn(true);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Use this object to prevent concurrent access to data

    await lock.synchronized(() async {
      // lazily instantiate the db the first time it is launched

      if (_database == null) {
        _database = await _initDatabase();

        _streamDatabase = BriteDatabase(_database!);
      }
    });
    return _database!;
  }

  Future<BriteDatabase> get streamDatabase async {
    await database;
    return _streamDatabase;
  }

  List<NoteItem> parseNoteItem(List<Map<String, dynamic>> noteList) {
    final notes = <NoteItem>[];

    noteList.forEach((noteMap) {
      final note = NoteItem.fromMap(noteMap);

      notes.add(note);
    });
    return notes;
  }

  List<TaskItem> parseTaskItem(List<Map<String, dynamic>> taskList) {
    final tasks = <TaskItem>[];

    taskList.forEach((taskMap) {
      final task = TaskItem.fromMap(taskMap);

      tasks.add(task);
    });
    return tasks;
  }

  Future<List<NoteItem>> findAllNotes() async {
    final db = await instance.streamDatabase;

    final noteList = await db.query(noteTable);
    final notes = parseNoteItem(noteList);
    return notes;
  }

  Future<List<TaskItem>> findAllTasks() async {
    final db = await instance.streamDatabase;

    final taskList = await db.query(taskTable);
    final tasks = parseTaskItem(taskList);
    return tasks;
  }

  Stream<List<NoteItem>> watchAllNotes() async* {
    final db = await instance.streamDatabase;

    yield* db.createQuery(noteTable).mapToList((row) => NoteItem.fromMap(row));
  }

  Stream<List<TaskItem>> watchAllTasks() async* {
    final db = await instance.streamDatabase;

    yield* db.createQuery(taskTable).mapToList((row) => TaskItem.fromMap(row));
  }

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;

    return db.insert(table, row);
  }


  Future<int> insertNote(NoteItem noteItem) {
    return insert(noteTable, NoteItem.toMap(noteItem));
  }

  Future<int> insertTask(TaskItem taskItem) {
    return insert(taskTable, TaskItem.toMap(taskItem));
  }

  Future<int> update(String table, Map<String, dynamic> row, String columnId,
      String id) async {
    final db = await instance.streamDatabase;

    return db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateNote(NoteItem noteItem) async {
    if (noteItem.cNoteId != null) {
      return update(
          noteTable, NoteItem.toMap(noteItem), cNoteId, noteItem.cNoteId!);
    } else {
      return Future.value(-1);
    }
  }

  Future<int> updateTask(TaskItem taskItem) async {
    if (taskItem.cTaskId != null) {
      return update(taskTable, TaskItem.toMap(taskItem), cTaskId, taskItem.cTaskId!);
    } else {
      return Future.value(-1);
    }
  }

  Future<int> _delete(String table, String columnId, String id) async {
    final db = await instance.streamDatabase;

    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(NoteItem noteItem) async {
    if (noteItem.cNoteId != null) {
      return _delete(noteTable, cNoteId, noteItem.cNoteId!);
    } else {
      return Future.value(-1);
    }
  }

  Future<int> deleteTask(TaskItem taskItem) async {
    if (taskItem.cTaskId != null) {
      return _delete(taskTable, cTaskId, taskItem.cTaskId!);
    } else {
      return Future.value(-1);
    }
  }

  void close() {
    _streamDatabase.close();
  }
}
