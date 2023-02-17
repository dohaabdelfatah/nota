import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlFliteModel {
  static Database? _db;
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
    }
    return _db;
  }

  initialDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'mydb.db');
    Database myDb = await openDatabase(
      path,
      onCreate: (db, version) async {
        await db.execute( "CREATE TABLE notes (id INTEGER PRIMARY KEY, note TEXT NOT NULL, title TEXT NOT NULL)");
      },
      version: 1
    );
    print('Successssssssssssssssssssssssssssssssssss');
    return myDb;
  }

  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }
}
