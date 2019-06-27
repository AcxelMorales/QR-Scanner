import 'dart:io';
import 'package:path/path.dart';
import 'package:qrreadapp/src/models/scann_model.dart';
export 'package:qrreadapp/src/models/scann_model.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DBProvider {
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  // Iniciar Base de Datos
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'Scanns_DB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database database, int version) async {
        await database.execute(
          'CREATE TABLE scanns ('
          'id INTEGER PRIMARY KEY,'
          'tipo TEXT,'
          'valor TEXT'
          ')'
        );
      }
    );
  }

  // POST
  insertRaw(ScannModel model) async {
    final db = await database;

    final res = db.rawInsert(
      "INSERT INTO scanns (id, tipo, valor) "
      "VALUES ('${model.id}', '${model.tipo}', '${model.valor}')"
    );

    return res;
  }

  Future<int> insertScann(ScannModel model) async {
    final db = await database;
    final res = await db.insert('scanns', model.toJson());
    return res;
  }

  // GET id
  Future<ScannModel> getScanById(int id) async {
    final db = await database;
    final res = await db.query('scanns', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty 
           ? ScannModel.fromJson(res.first) 
           : null;
  }

  // GET All
  Future<List<ScannModel>> getAll() async {
    final db = await database;
    final res = await db.query('scanns');

    List<ScannModel> list = res.isNotEmpty 
                            ? res.map((ms) => ScannModel.fromJson(ms) ).toList() 
                            : [];

    return list;
  }

  // GET fron tipo
  Future<List<ScannModel>> getAllFromType(String tipo) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM scanss WHERE tipo='$tipo'");

    List<ScannModel> list = res.isNotEmpty 
                            ? res.map((ms) => ScannModel.fromJson(ms) ).toList() 
                            : [];

    return list;
  }

  // UPDATE
  Future<int> updateScann(ScannModel model) async {
    final db = await database;
    final res = await db.update('scanns', model.toJson(), where: 'id = ?', whereArgs: [model.id]);
    return res;
  }

  // DELETE
  Future<int> deleteScann(int id) async {
    final db = await database;
    final res = await db.delete('scanns', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // DELETE All
  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete("DELETE FROM scanns");
    return res;
  }
}
