import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app/models/todo.dart';

class AppDb {
  AppDb._privateConstructor();
  static final AppDb instance = AppDb._privateConstructor();
  static const String _tableName = 'todo';
  static Database? _db;
  Future<Database> get database async => _db ??= await _initDB('todo.db');

  Future<Database> _initDB(String fileName) async {
    final dir = await getApplicationDocumentsDirectory();
    final path = join(dir.path, fileName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        is_done INTEGER NOT NULL DEFAULT 0,
        created_at INTEGER NOT NULL,
        updated_at INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insertTodo(Todo todo) async {
    final db = await database;
    final row = todo.toMap(); 
    row.remove('id'); 
    return await db.insert(_tableName, row);
  }

  /// Queries all todos from the database and returns them as a List<Todo>.
  Future<List<Todo>> queryAllTodos() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(_tableName, orderBy: 'updated_at DESC');

    return maps
        .map((map) => Todo.fromMap({
              'id': map['id'],
              'title': map['title'],
              'is_done': map['is_done'] as int,
              'created_at': map['created_at'],
              'updated_at': map['updated_at'],
            }))
        .toList();
  }

  Future<int> updateTodo(Todo todo) async {
    if (todo.id == null) return 0;
    final db = await database;
    todo.updatedAt = DateTime.now();

    final Map<String, dynamic> row = {
      'id': todo.id,
      'title': todo.title,
      'is_done': todo.isDone ? 1 : 0,
      'created_at': todo.createdAt.millisecondsSinceEpoch,
      'updated_at': todo.updatedAt.millisecondsSinceEpoch,
    };

    return await db.update(
      _tableName,
      row,
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<int> deleteTodo(int? id) async {
    if (id == null) return 0;
    final db = await database;
    return await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
  }
}
