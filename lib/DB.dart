import 'dart:io';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutterlessons/Question.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

abstract class DB {

  static Database _database;

  static Future<void> init() async{
    if(_database != null){
      print('Database is exists!');
      return;
    }
    try{
      String _path = await getDatabasesPath()+'/ectheory.db';
      print('--FROM init() -- trying to copy database file into $_path');
      copyDatabase(_path);
    } catch(ex){
      print(ex.toString());
    }
  }

  static copyDatabase(String path) async{
    ByteData buffer = await rootBundle.load('assets/ectheory.db');
    List<int> bytes = buffer.buffer.asUint8List(buffer.offsetInBytes, buffer.lengthInBytes);
    await File(path).writeAsBytes(bytes);
    print('Database file has been written successfuly');
  }
  static Future <List<Question>>Select(String table, List condition) async{
    _database.query(table, whereArgs: condition);
  }
}
