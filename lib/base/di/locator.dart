import 'package:get_it/get_it.dart';
import 'package:todoapp/datasource/repo/task_repo.dart';
import 'package:todoapp/feature/add_new_task/add_new_task_viewmodel.dart';
import 'package:todoapp/feature/main/main_screen_viewmodel.dart';
import 'package:todoapp/feature/task_list/task_list_viewmodel.dart';

GetIt locator = GetIt.instance;

void setUpInjector() {
  /// Inject repo
  locator.registerLazySingleton<TaskRepo>(() => TaskRepoImpl());

  /// Inject view model
  locator.registerFactory<MainScreenViewModel>(() => MainScreenViewModel());
  locator.registerFactory<TaskListViewModel>(() => TaskListViewModel());
  locator.registerFactory<AddNewTaskViewModel>(() => AddNewTaskViewModel());
}
