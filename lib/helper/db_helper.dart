import 'dart:developer';

import 'package:exam_adv/model/receipe_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();

  Database? db;
  String tableName = 'receipe';
  String receipeName = 'res_name';
  String receipeDes = 'res_des';

  Future<void> initDb() async {
    var databasePath = await getDatabasesPath();
    String path = "${databasePath}receipe.db";

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (db, _) async {
        String query =
            'CREATE TABLE $tableName (res_id INTEGER PRIMARY KEY, $receipeName TEXT, $receipeDes TEXT);';
        await db.execute(query);
      },
    );
  }

  //  Insert Records
  Future<int?> insertreceipe(String name, String description) async {
    await initDb();
    String query =
        "INSERT INTO $tableName($receipeName,$receipeDes) VALUES(?,?);";
    int? id = await db?.rawInsert(query, [name, description]);
    log('$id');

    return id;
  }

  //Update  Records
  Future<int?> updateRecord(ReceipeModel model) async {
    await initDb();

    String query =
        "UPDATE $tableName SET $receipeName=?,$receipeDes=? WHERE res_id=${model.id}";
    return await db?.rawUpdate(query, [model.name, model.des, model.id]);
  }

  //Fetch Record
  Future<List<ReceipeModel>> fetchRecord() async {
    await initDb();
    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> fetchReceipe = await db?.rawQuery(query) ?? [];
    log('${fetchReceipe}');
    var i = fetchReceipe
        .map(
          (e) => ReceipeModel.mapToModel(e),
        )
        .toList();
    log('===============');
    log("$i");
    log('===============');
    return i;
  }

  //Delete Record
  Future<int?> deleteRecord(int recId) async {
    await initDb();
    String query = "DELETE FROM $tableName WHERE res_id=$recId";
    return await db?.rawDelete(query);
  }
}
