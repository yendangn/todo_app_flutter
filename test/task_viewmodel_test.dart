import 'package:flutter_test/flutter_test.dart' as futtertest;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/datasource/repo/task_repo.dart';
import 'package:todoapp/feature/task_list/task_list_screen.dart';
import 'package:todoapp/feature/task_list/task_list_viewmodel.dart';
import 'package:todoapp/schema/task.dart';

class MockTaskRepo extends Mock implements TaskRepo {}

void main() {
  futtertest.TestWidgetsFlutterBinding.ensureInitialized();

  locator.registerLazySingleton<TaskRepo>(() => MockTaskRepo());
  var _taskRepo = locator<TaskRepo>();
  var _taskListViewModel = TaskListViewModel();

  group('Task ViewModel  Test | ', () {
    test('Update task successfully with screen type is ALL', () async {
      _taskListViewModel.tasks = [
        Task(
          id: 1,
          name: 'Test',
          status: TaskStatus.Completed,
        )
      ];

      when(_taskRepo.updateTaskById(_taskListViewModel.tasks[0]))
          .thenAnswer((_) async => Future.value(1));

      await _taskListViewModel.updateTaskStatus(
          0, TaskStatus.New, TaskListScreenType.ALL);

      expect(_taskListViewModel.tasks[0].status, TaskStatus.New);
    });

    test('Update task successfully with screen type is not ALL', () async {
      _taskListViewModel.tasks = [
        Task(
          id: 1,
          name: 'Test',
          status: TaskStatus.Completed,
        )
      ];

      when(_taskRepo.updateTaskById(_taskListViewModel.tasks[0]))
          .thenAnswer((_) async => Future.value(1));

      await _taskListViewModel.updateTaskStatus(
          0, TaskStatus.New, TaskListScreenType.COMPLETED);

      expect(_taskListViewModel.tasks.isEmpty, true);
    });

    test('Update task fail', () async {
      _taskListViewModel.tasks = [
        Task(
          id: 1,
          name: 'Test',
          status: TaskStatus.Completed,
        )
      ];

      when(_taskRepo.updateTaskById(_taskListViewModel.tasks[0]))
          .thenAnswer((_) async => Future.value(0));

      await _taskListViewModel.updateTaskStatus(
          0, TaskStatus.New, TaskListScreenType.COMPLETED);

      expect(_taskListViewModel.tasks[0].status, TaskStatus.Completed);
    });

    test('Update task fail', () async {
      _taskListViewModel.tasks = [
        Task(
          id: 1,
          name: 'Test',
          status: TaskStatus.Completed,
        )
      ];

      when(_taskRepo.updateTaskById(_taskListViewModel.tasks[0]))
          .thenAnswer((_) async => Future.value(0));

      await _taskListViewModel.updateTaskStatus(
          0, TaskStatus.New, TaskListScreenType.COMPLETED);

      expect(_taskListViewModel.tasks[0].status, TaskStatus.Completed);
    });
  });
}
