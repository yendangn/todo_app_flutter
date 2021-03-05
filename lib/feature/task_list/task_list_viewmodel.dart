import 'package:todoapp/base/base_refreshable_viewmodel.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/datasource/repo/task_repo.dart';
import 'package:todoapp/feature/task_list/task_list_screen.dart';
import 'package:todoapp/schema/task.dart';
import 'package:todoapp/type/loading_type.dart';

class TaskListViewModel extends BaseRefreshAbleViewModel {
  final TaskRepo _taskRepo = locator<TaskRepo>();
  List<Task> tasks = [];

  void getData({
    LoadingType loadingType = LoadingType.New,
    TaskListScreenType type = TaskListScreenType.ALL,
  }) async {
    switch (loadingType) {
      case LoadingType.New:
      case LoadingType.Refresh:
        _getNewOrRefreshData(loadingType, type);
        break;

      case LoadingType.LoadMore:
        //TODO
        break;
    }
  }

  void _getNewOrRefreshData(
      LoadingType loadingType, TaskListScreenType type) async {
    if (loadingType == LoadingType.New) {
      startLoading();
    }

    switch (type) {
      case TaskListScreenType.ALL:
        tasks = await _taskRepo.getAllTask();
        break;

      case TaskListScreenType.NEW:
        tasks = await _taskRepo.getTasksByStatus(TaskStatus.New);
        break;

      case TaskListScreenType.COMPLETED:
        tasks = await _taskRepo.getTasksByStatus(TaskStatus.Completed);
        break;
    }

    stopLoading();

    if (loadingType == LoadingType.Refresh) {
      refreshController.refreshCompleted();
    }
  }

  void updateTaskStatus(
      int index, TaskStatus newStatus, TaskListScreenType type) async {
    var task = tasks[index];

    var count = await _taskRepo.updateTaskById(task);

    if (count > 0) {
      if (type == TaskListScreenType.ALL) {
        tasks[index].status = newStatus;
      } else {
        tasks.removeAt(index);
      }

      notifyListeners();
    }
  }
}
