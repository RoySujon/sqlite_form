import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';
import 'package:sqlite_form/models/user_model.dart';

class UserDB {
  static final String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL';
  static final String textType = 'TEXT';
  static final String timeTampType =
      'TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP';
  static final String tableName = 'Users';

  static Future createTable(sql.Database db) async {
    await db.execute('''CREATE TABLE $tableName (
      id $idType,
      name $textType,
      phone $textType,
      adress $textType,
      email $textType,
      createAt $timeTampType
     )''');
  }

  static Future<sql.Database> initDb() async {
    return await sql.openDatabase('users.db',
        onCreate: (db, version) => createTable(db), version: 1);
  }

  static Future<int> createUser(UserModel userModel) async {
    final db = await initDb();
    print("insert Data");
    return await db.insert(tableName, userModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(UserModel userModel, int id) async {
    final db = await initDb();
    print("Update Data");
    return await db.update(tableName, {"name": userModel.name},
        // conflictAlgorithm: ConflictAlgorithm.rollback,
        where: "id = ?",
        whereArgs: [id]);
  }

  static Future<List<UserModel>> getUsers() async {
    final db = await initDb();
    final map = await db.query(tableName, orderBy: "createAt");
    return map.map((e) => UserModel.fromJson(e)).toList();
  }

  static Future<List<UserModel>> getUser(String id) async {
    final db = await initDb();
    final map = await db.query(tableName, where: "id = ?", whereArgs: [id]);
    return map.map((e) => UserModel.fromJson(e)).toList();
  }

  static Future<int> deleteUser(String id) async {
    final db = await initDb();
    final map = await db.delete(tableName, where: "id = ?", whereArgs: [id]);
    return map;
  }
}
