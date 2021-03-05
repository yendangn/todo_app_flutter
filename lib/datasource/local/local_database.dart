import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/logger/app_logger.dart';
import 'package:todoapp/schema/entity/task_entity.dart';

class DBProvider {
  DBProvider.a();

  static final DBProvider db = DBProvider.a();

  Database _database;

  final String _dbName = 'todo_app.db';

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    var documentsDirectory = await getDatabasesPath();
    var path = join(documentsDirectory, _dbName);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE ${TaskEntity.tableName} ('
          'id INTEGER PRIMARY KEY,'
          'name TEXT,'
          'status TEXT,'
          'created_at TEXT'
          ')');
    });
  }

  Future<int> addNewTask(TaskEntity task) async {
    try {
      final db = await database;
      //get the biggest id in the table
      var table = await db
          .rawQuery('SELECT MAX(id)+1 as id FROM ${TaskEntity.tableName}');
      task.id = table.first['id'];
      return await db.insert(
        TaskEntity.tableName,
        task.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (error) {
      AppLogger.e(error);
      return 0;
    }
  }

  Future<List<TaskEntity>> getAllTask() async {
    try {
      final db = await database;
      var res = await db.query(
        TaskEntity.tableName,
        orderBy: 'created_at DESC',
      );
      var list =
          res.isNotEmpty ? res.map((c) => TaskEntity.fromJson(c)).toList() : [];

      return list;
    } catch (error) {
      AppLogger.e(error);
      return [];
    }
  }

  Future<List<TaskEntity>> getTasksByStatus(String status) async {
    try {
      final db = await database;
      var res = await db.query(
        TaskEntity.tableName,
        where: 'status = ?',
        whereArgs: [status],
        orderBy: 'created_at DESC',
      );
      return res.isNotEmpty
          ? res.map((c) => TaskEntity.fromJson(c)).toList()
          : [];
    } catch (error) {
      AppLogger.e(error);
      return [];
    }
  }

  Future<int> updateTaskById(TaskEntity newTask) async {
    try {
      final db = await database;
      var res = await db.update(
        TaskEntity.tableName,
        newTask.toJson(),
        where: 'id = ?',
        whereArgs: [newTask.id],
      );
      return res;
    } catch (error) {
      AppLogger.e(error);
      return 0;
    }
  }
}
