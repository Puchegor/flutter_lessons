import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database>get database async{
    if (_database != null)
      return _database;
    else
      copyDatabase();
  }

  copyDatabase() async{
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String dbPath = documentDirectory.path+ "ectheory.db";
  }
}
