import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user.dart';
import '../models/calculation.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(username TEXT PRIMARY KEY, password TEXT, email TEXT)',
    );
    await db.execute(
      'CREATE TABLE calculations(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, operation TEXT, operand1 REAL, operand2 REAL, result REAL, FOREIGN KEY(username) REFERENCES users(username))',
    );
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> getUser(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
    );
    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }
    return null;
  }

  Future<void> insertCalculation(Calculation calculation) async {
    final db = await database;
    await db.insert(
      'calculations',
      calculation.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Calculation>> getUserCalculations(String username) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'calculations',
      where: 'username = ?',
      whereArgs: [username],
      orderBy: 'id DESC',
    );
    return List.generate(maps.length, (i) {
      return Calculation.fromMap(maps[i]);
    });
  }
}
