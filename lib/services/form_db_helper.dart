import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sql.dart';

class DBHelper {
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
    return await sql.openDatabase('user.db',
        onCreate: (db, version) => createTable(db), version: 1);
  }

  static Future<int> createUser(
      {required String name,
      required String phone,
      required String email,
      required String adress}) async {
    final db = await initDb();
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "adress": adress,
      "email": email
    };
    print(data);
    return await db.insert(tableName, data,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateUser(
      {required int id,
      required String name,
      required String phone,
      required String email,
      required String adress}) async {
    final db = await initDb();
    Map<String, dynamic> data = {
      "name": name,
      "phone": phone,
      "adress": adress,
      "email": email,
      "createAT": DateTime.now().toString(),
    };
    print(data);
    return await db.update(tableName, data, where: "id = ?", whereArgs: [id]);
  }

  static Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await initDb();
    final data = await db.query(tableName) as List<Map<String, dynamic>>;

    return data;
  }

  static Future<List<Map<String, dynamic>>> getUser({required int id}) async {
    final db = await initDb();
    return await db.query(tableName, where: "id = ?", whereArgs: [id]);
  }

  static Future<int> deleteUser({required int id}) async {
    final db = await initDb();
    return await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
