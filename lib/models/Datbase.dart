import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHandler {
  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      final path = join(directory.path, 'Shabdkosh.db'); // Ensure the file extension for SQLite
      _db = await openDatabase(path, version: 1, onCreate: _onCreate);
      return _db!;
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS Shabdkosh (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        Word TEXT
      )
    ''');
  }

  Future<void> insertData(String word) async {
    final dbClient = await db;
    await dbClient.insert('Shabdkosh', {'Word': word});
    print("Data inserted: $word");
  }

  Future<List<Map<String, dynamic>>> fetchAllWords() async {
    final dbClient = await db;
    final list = await dbClient.query('Shabdkosh');
    return list;
  }


    Future<void> deleteWord(int id) async {
    final dbClient = await db;
    await dbClient.delete(
      'Shabdkosh',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
