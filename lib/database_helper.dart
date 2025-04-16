import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('health_manager.db');
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // جدول الأطباء
    await db.execute('''
      CREATE TABLE medecins (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        specialite TEXT NOT NULL,
        telephone TEXT NOT NULL
      )
    ''');

    // جدول الأدوية
    await db.execute('''
      CREATE TABLE medicaments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nom TEXT NOT NULL,
        description TEXT NOT NULL,
        dosage TEXT NOT NULL,
        reminderTime TEXT NOT NULL
      )
    ''');

    // جدول المواعيد
    await db.execute('''
      CREATE TABLE rendezvous (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        titre TEXT NOT NULL,
        description TEXT NOT NULL,
        dateTime TEXT NOT NULL
      )
    ''');

    // جدول الوصفات الطبية
    await db.execute('''
      CREATE TABLE prescriptions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        medicamentId INTEGER NOT NULL,
        medecinId INTEGER NOT NULL,
        instructions TEXT NOT NULL,
        FOREIGN KEY (medicamentId) REFERENCES medicaments (id),
        FOREIGN KEY (medecinId) REFERENCES medecins (id)
      )
    ''');
  }

  Future<void> deleteDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'health_manager.db');
    await deleteDatabase(path);
  }

  Future<List<Map<String, dynamic>>> getAllMedicaments() async {
  final db = await database; // Access the database instance
  return await db.query('medicaments'); // Query all rows from the 'medicaments' table
}
}
