import 'dart:async';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();

  static Database? _database;
  Future<Database> get database async => _database ?? await _initDatabase();

  Future<Database> _initDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, "articles.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
        CREATE TABLE articles(
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            content TEXT NOT NULL,
            url TEXT PRIMARY KEY,
            image TEXT NOT NULL,
            published_at INTEGER NOT NULL,
            source_name TEXT NOT NULL,
            source_url TEXT NOT NULL
        )
    ''');
  }

  Future<List<Map<String, dynamic>>> getArticles() async {
    final db = await database;
    return await db.query('articles');
  }

  Future<int> addArticle({required Map<String, dynamic> article}) async {
    final db = await database;
    return db.insert('articles', article, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<int> removeArticle({required String id}) async {
    final db = await database;
    return db.delete('articles', where: 'url = ?', whereArgs: [id]);
  }

  Future<int> removeAllArticles() async {
    final db = await database;
    return db.delete('articles');
  }
}
