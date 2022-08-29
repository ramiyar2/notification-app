import 'package:flutter/cupertino.dart';
import 'package:notification_app/models/reminder.dart';
import 'package:sqflite/sqflite.dart';
import '../models/task.dart';

class HelperDb {
  static Database? _db;
  static const int _version = 1;
  static const String _nameTaskes = 'myTaskes';
  static const String _nameNofiye = 'myNofiye';
  static initDb() async {
    if (_db != null) {
      debugPrint('we already have db');
      return;
    } else {
      try {
        // Get a location using getDatabasesPath
        var databasesPath = await getDatabasesPath() + 'taskes.db';
        debugPrint(databasesPath);
        // open the database
        _db = await openDatabase(databasesPath, version: _version,
            onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              'CREATE TABLE $_nameTaskes (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note STRING, remindTime STRING, date STRING)');
          await db.execute(
              'CREATE TABLE $_nameNofiye (id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note STRING, remindTime STRING, date STRING)');
        });
        debugPrint('db created');
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static Future<int> putData(
      {Task? task, Reminder? reminder, required bool isNotify}) async {
    print('data inserted');
    return isNotify
        ? await _db!.insert(_nameNofiye, reminder!.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace)
        : await _db!.insert(_nameTaskes, task!.toJson(),
            conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> quary(
      {required bool isNotify}) async {
    print('quary called');
    return isNotify
        ? await _db!.query(_nameNofiye)
        : await _db!.query(_nameTaskes);
  }

  static Future<int> delete(
      {Task? task, Reminder? reminder, required bool isNotify}) async {
    return isNotify
        ? await _db!
            .delete(_nameNofiye, where: 'id = ?', whereArgs: [reminder!.id])
        : await _db!
            .delete(_nameTaskes, where: 'id = ?', whereArgs: [task!.id]);
  }

  static Future<int> update(
      {Task? task, Reminder? reminder, required bool isNotify}) async {
    return isNotify
        ? await _db!.update(_nameNofiye, reminder!.toJson())
        : await _db!.update(_nameTaskes, task!.toJson());
  }
}
