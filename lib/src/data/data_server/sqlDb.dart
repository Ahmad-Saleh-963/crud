



// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlLite{

  static Database? _db;

  Future<Database?> get db async{
    _db ??= await initDB();
    return _db;
  }

  initDB()async{
    String dbPath = await getDatabasesPath();
    String path = join(dbPath , 'ahmad.db');
    Database mydb = await openDatabase(path, onCreate:  _onCreate,version: 1,onUpgrade: _onUpgrade);
    return mydb;
  }

  _onCreate(Database db , int version)async{
    await db.execute('CREATE TABLE data (id INTEGER PRIMARY KEY, title TEXT, userId INTEGER, body TEXT ,  idback TEXT )');
  }

  _onUpgrade(Database db , int oldVersion,int newVersion)async{

  }

  readData(String sql)async{
    Database? mydb = await db;
    var response = mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql)async{
    Database? mydb = await db;
    var response = mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql)async{
    Database? mydb = await db;
    var response = mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql)async{
    Database? mydb = await db;
    var response = mydb!.rawDelete(sql);
    return response;
  }

}