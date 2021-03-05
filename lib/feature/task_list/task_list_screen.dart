import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/base/base_screen.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/feature/task_list/task_list_viewmodel.dart';
import 'package:todoapp/feature/task_share_viewmodel.dart';
import 'package:todoapp/resources/app_dimen.dart';
import 'package:todoapp/resources/app_lang.dart';
import 'package:todoapp/schema/task.dart';
import 'package:todoapp/type/loading_type.dart';
import 'package:todoapp/util/ui_util.dart';
import 'package:todoapp/widget/app_bar_widget.dart';
import 'package:todoapp/widget/task_item_widget.dart';

enum TaskListScreenType {
  ALL,
  NEW,
  COMPLETED,
}

class TaskListScreen extends StatefulWidget {
  final TaskListScreenType type;

  TaskListScreen({
    this.type,
  });

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends BaseScreen<TaskListScreen> {
  TaskListViewModel taskListViewModel = locator<TaskListViewModel>();

  @override
  void initState() {
    _getData();
    super.initState();
  }

  void _getData({LoadingType loadingType = LoadingType.New}) {
    taskListViewModel.getData(
      loadingType: loadingType,
      type: widget.type,
    );
  }

  @override
  Widget build(BuildContext context) {
    ///https://pub.dev/packages/provider#faq
    _reloadData();
    return ChangeNotifierProvider(
      create: (context) => taskListViewModel,
      child: Consumer<TaskListViewModel>(
        builder: (context, taskListViewModel, child) {
          return Scaffold(
            appBar: AppBarWidget(
              mTitle: _getScreenTitle(),
            ),
            body: buildContainerViewByStatus(
                taskListViewModel, _buildContentView(), () {}),
          );
        },
      ),
    );
  }

  String _getScreenTitle() {
    switch (widget.type) {
      case TaskListScreenType.ALL:
        return getStringFromRes(AppLang.task_list_all_title);

      case TaskListScreenType.NEW:
        return getStringFromRes(AppLang.task_list_new_title);

      case TaskListScreenType.COMPLETED:
        return getStringFromRes(AppLang.task_list_completed_title);
    }
    return '';
  }

  Widget _buildContentView() {
    var tasks = taskListViewModel.tasks;

    if (tasks.isEmpty) {
      return buildEmptyView(
        getStringFromRes(AppLang.task_list_empty),
        _getData,
      );
    }

    Widget view = ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(AppDimen.app_margin),
          child: TaskItemWidget(
            task: tasks[index],
            onUpdateTaskStatus: (TaskStatus newStatus) {
              onUpdateTaskStatus(index, newStatus);
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) => UiUtil.buildLine(),
      itemCount: tasks.length,
    );

    return buildRefreshView(
      view,
      taskListViewModel.refreshController,
      () {
        _getData(loadingType: LoadingType.Refresh);
      },
    );
  }

  void onUpdateTaskStatus(int index, TaskStatus newStatus) {
    taskListViewModel.updateTaskStatus(index, newStatus, widget.type);
    _updateReloadData();
  }

  void _reloadData() {
    var taskShareViewModel =
        Provider.of<TaskShareViewModel>(context, listen: true);

    if (taskShareViewModel.reloadScreenData.contains(widget.type)) {
      taskShareViewModel.removeReload(widget.type);
      _getData();
    }
  }

  void _updateReloadData() {
    var pages = <TaskListScreenType>[
      TaskListScreenType.ALL,
      TaskListScreenType.NEW,
      TaskListScreenType.COMPLETED
    ];

    /// Don't need reload current page.
    pages.remove(widget.type);

    Provider.of<TaskShareViewModel>(context, listen: false).setReload(pages);
  }
}
