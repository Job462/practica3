import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  late Database _database;
  late bool _isDatabaseInitialized;

  DatabaseHelper() {
    _isDatabaseInitialized = false;
  }

  Future<void> _initializeDatabase() async {
    if (!_isDatabaseInitialized) {
      String path = join(await getDatabasesPath(), 'transactions.db');
      _database = await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE transactions(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            description TEXT,
            amount REAL,
            type TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE balance(
            amount REAL
          )
        ''');
      });
      _isDatabaseInitialized = true;
    }
  }

  Future<Database> get database async {
    await _initializeDatabase();
    return _database;
  }
}
