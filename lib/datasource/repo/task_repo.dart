import 'package:enum_to_string/enum_to_string.dart';
import 'package:todoapp/base/base_repo.dart';
import 'package:todoapp/datasource/local/local_database.dart';
import 'package:todoapp/schema/entity/task_entity.dart';
import 'package:todoapp/schema/task.dart';

abstract class TaskRepo {
  Future<int> addNewTask(Task task);

  Future<List<Task>> getAllTask();

  Future<List<Task>> getTasksByStatus(TaskStatus status);

  Future<int> updateTaskById(Task newTask);
}

class TaskRepoImpl extends BaseRepository implements TaskRepo {
  @override
  Future<int> addNewTask(Task task) {
    return DBProvider.db.addNewTask(TaskEntity.fromTask(task));
  }

  @override
  Future<List<Task>> getAllTask() async {
    var tasksEntity = await DBProvider.db.getAllTask();

    return tasksEntity
        .map((taskEntity) => Task.fromTaskEntity(taskEntity))
        .toList();
  }

  @override
  Future<List<Task>> getTasksByStatus(TaskStatus status) async {
    var tasksEntity = await DBProvider.db
        .getTasksByStatus(EnumToString.convertToString(status));

    return tasksEntity
        .map((taskEntity) => Task.fromTaskEntity(taskEntity))
        .toList();
  }

  @override
  Future<int> updateTaskById(Task newTask) {
    return DBProvider.db.updateTaskById(TaskEntity.fromTask(newTask));
  }
}
