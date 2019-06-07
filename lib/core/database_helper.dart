import 'dart:core';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoapp/models/note.dart';

class DatabaseHelper {
  
  static final String _databaseName = 'todo.db';
  static final int _databaseVersion = 1;

  static DatabaseHelper _databaseHelper = DatabaseHelper._internal();
  static Database _database;

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    return _databaseHelper;
  }

  DatabaseHelper._internal() {
    _databaseHelper = DatabaseHelper._createInstance();
  }

  Future<Database> get database async {
    if( _database == null )
      _database = await initializeDatabase();
    
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/$_databaseName';

    return openDatabase(path, version: _databaseVersion, onCreate: _createDb);
  }

  static void deleteDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/$_databaseName';
    
    deleteDatabase(path);
  }

  static void _createDb( Database db, int version ) async {
    await db.execute( Note.initDB() );
  }

  static void emptyAllTables() {
    _databaseHelper.clearTableContent( Note.table );
  }

  Future<int> clearTableContent( String table ) async {
    Database db = await this.database;
    var result = await db.rawDelete( 'DELETE FROM $table' );

    return result;
  }

  Future<List<dynamic>> getList( String table, {String where, int limit, String orderBy} ) async {
    Database db = await this.database;
    var result = await db.query( table, where:where, limit: limit, orderBy: orderBy );
    
    return result;
  }

  Future<int> insert( String table, dynamic model ) async {
    Database db = await this.database;
    var result = await db.insert( table, model.toMap() );

    return result;
  }

  Future<int> update( String table, dynamic model ) async {
    Database db = await this.database;
    var result = await db.update( table, model.toMap(), where: 'id = ?', whereArgs: [model.id] );

    return result;
  }

  Future<int> delete( String table, int id ) async {
    Database db = await this.database;
    var result = await db.rawDelete( 'DELETE FROM $table WHERE id = $id' );

    return result;
  }

  Future<int> getCount( String table ) async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery( 'SELECT COUNT (*) from $table' );
    return Sqflite.firstIntValue(x);
  }
}