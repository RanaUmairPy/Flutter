import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'demo.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE texts(id INTEGER PRIMARY KEY AUTOINCREMENT, value TEXT)',
        );
      },
    );
  }

  static Future<void> insertText(String text) async {
    final db = await database;
    await db.insert('texts', {'value': text});
  }

  // Add this method:
  static Future<List<String>> getAllTexts() async {
    final db = await database;
    final result = await db.query('texts', orderBy: 'id DESC');
    return result.map((row) => row['value'] as String).toList();
  }
}