import 'package:todoapp/base/base_viewmodel.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/datasource/repo/task_repo.dart';
import 'package:todoapp/schema/task.dart';

class AddNewTaskViewModel extends BaseViewModel {
  final TaskRepo _taskRepo = locator<TaskRepo>();

  Future<int> addNewTask(String name) {
    return _taskRepo.addNewTask(Task(
      name: name,
      status: TaskStatus.New,
      createdAt: DateTime.now(),
    ));
  }
}
