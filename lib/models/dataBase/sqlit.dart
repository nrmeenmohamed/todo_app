import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {

  static Database? _db;

  // check if database initialize or not to initialize once time
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    }
    else {
      return _db;
    }
  }

  // configure database
  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'taskease.db');
    Database myDb = await openDatabase(path, onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  // create new version of database
  _onUpgrade(Database db, int oldVersion, int newVersion){
    print("_onUpgrade new version of database============================================");
  }

  // create table
  _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE tasks (
            id INTEGER PRIMARY KEY NOT NULL,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            category TEXT NOT NULL,
            done INTEGER NOT NULL
          )
        ''');
    print("_onCreate Create Database and Tables ==============================================");
  }

  // delete database
  dropDatabase()async{
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'taskease.db');
    await deleteDatabase(path);
    print("DELETE DATABASE ==============================================");

  }

  // select data from database
  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  // insert data to database
  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  // update date in database
  updateData(String sql, List<Object> list)async{
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql, list);
    return response;
  }

  // delete data from database
  deleteData(String sql, List<int> list)async{
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql,list);
    return response;
  }
}