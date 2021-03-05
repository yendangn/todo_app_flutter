import 'package:todoapp/base/base_viewmodel.dart';
import 'package:todoapp/feature/task_list/task_list_screen.dart';

class TaskShareViewModel extends BaseViewModel {
  List<TaskListScreenType> reloadScreenData = [];

  void setReload(List<TaskListScreenType> data) {
    reloadScreenData.addAll(data);
    notifyListeners();
  }

  void removeReload(TaskListScreenType data) {
    reloadScreenData.remove(data);
  }
}
