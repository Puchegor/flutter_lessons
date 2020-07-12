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
    if (await File(_dbPath).exists()) {
      _database = await openDatabase(_dbPath);
      return;
    }
    try{
      copyDatabase(_dbPath);
      _database = await openDatabase(_dbPath);
    } catch(ex){
      print(ex.toString());
    }
  }

  static copyDatabase(String path) async{
    ByteData data = await rootBundle.load('assets/ectheory.db');
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes);
  }

  static Future <List<Map>>select(String sql) async{
    return await _database.rawQuery(sql);
    /*resultSet.forEach((row) => print(row) );
    int i = resultSet.length;
    print('ResultSet lenfth is $i');*/
  }
}
