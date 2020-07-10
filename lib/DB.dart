import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static var _dbDir;
  static const String _dbName = 'ectheory.db';
  static var _dbPath;
  static Database _database;

  static Future<void> init() async{
    _dbDir = await getDatabasesPath();
    _dbPath = join(_dbDir, _dbName);
    _database = await openDatabase(_dbPath);
    if(_database != null){
      print('Database is exists!');
      return;
    }
    try{
      print('--FROM init() -- trying to copy database file into $_dbPath');
      copyDatabase(_dbPath);
    } catch(ex){
      print(ex.toString());
    }
  }

  static copyDatabase(String path) async{
    ByteData buffer = await rootBundle.load('assets/ectheory.db');
    List<int> bytes = buffer.buffer.asUint8List(buffer.offsetInBytes, buffer.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  static Future <List<Map>>select(String table, {List condition}) async{
    Future<List<Map>> resultSet = _database.query(table, whereArgs: condition);
  }
}
