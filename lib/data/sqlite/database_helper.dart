import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlbrite/sqlbrite.dart';
import 'package:synchronized/synchronized.dart';
import 'package:gigi_notes/models/models.dart';

class DatabaseHelper {
  static const _databaseName = 'GigiNotesNew1.db';
  static const _databaseVersion = 2;

  static const noteTable = 'GigiNotes';
  static const noteId = 'noteId';

  static late BriteDatabase _streamDatabase;

  // make this a singleton class
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static var lock = Lock();

  // only have a single app-wide reference to the database
  static Database? _database;

  // TODO: Add create database code here

  // SQL code to create the database tables

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $noteTable (
            $noteId INTEGER PRIMARY KEY,
            cNoteId INTEGER,
            title TEXT,
            noteText TEXT,
            dateTime TEXT,
            isComplete INTEGER
          )
          ''');
  }

  // TODO: Add code to open database

  // This opens the database (and creates it if it doesn't already exist)

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, _databaseName);

    // TODO: Remember to turn off debugging before deploying to app store(s)
    Sqflite.setDebugModeOn(true);

    return openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // TODO: Add initialize getter here

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

  // TODO: Add getter for streamDatabase

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

  // TODO: Add findAllNotes here

  Future<List<NoteItem>> findAllNotes() async {
    final db = await instance.streamDatabase;

    final noteList = await db.query(noteTable);
    final notes = parseNoteItem(noteList);
    return notes;
  }

  // TODO: Add watchAllNotes here

  Stream<List<NoteItem>> watchAllNotes() async* {
    final db = await instance.streamDatabase;

    yield* db
        .createQuery(noteTable)
        .mapToList((row) => NoteItem.fromMap(row));
  }

  // TODO: Insert methods go here

  Future<int> insert(String table, Map<String, dynamic> row) async {
    final db = await instance.streamDatabase;

    return db.insert(table, row);
  }

  Future<int> insertNote(NoteItem noteItem) {
    return insert(noteTable, noteItem.toMap());
  }

  // TODO: Update methods go here

  Future<int> update(String table, Map<String, dynamic> row, String columnId, String id) async {
    final db = await instance.streamDatabase;

    return db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateNote(NoteItem noteItem) async {
    if (noteItem.cNoteId != null) {
      return update(noteTable, noteItem.toMap(), noteId, noteItem.cNoteId!);
    } else {
      return Future.value(-1);
    }
  }

  // TODO: Delete methods go here

  Future<int> _delete(String table, String columnId, String id) async {
    final db = await instance.streamDatabase;

    return db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> deleteNote(NoteItem noteItem) async {
    if (noteItem.cNoteId != null) {
      return _delete(noteTable, noteId, noteItem.cNoteId!);
    } else {
      return Future.value(-1);
    }
  }

  void close() {
    _streamDatabase.close();
  }
}