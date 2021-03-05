import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:todoapp/base/base_screen.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/feature/add_new_task/add_new_task_viewmodel.dart';
import 'package:todoapp/feature/task_list/task_list_screen.dart';
import 'package:todoapp/feature/task_share_viewmodel.dart';
import 'package:todoapp/main.route.dart';
import 'package:todoapp/resources/app_dimen.dart';
import 'package:todoapp/resources/app_lang.dart';
import 'package:todoapp/widget/add_task_form_widget.dart';
import 'package:todoapp/widget/app_bar_widget.dart';
import 'package:todoapp/widget/app_button_widget.dart';
import 'package:todoapp/widget/keyboard_dismisser_widget.dart';

@RoutePage()
class AddNewTaskScreen extends StatefulWidget {
  static void start(BuildContext context) {
    Navigator.of(context).pushNamed(ROUTE_ADD_NEW_TASK_SCREEN);
  }

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends BaseScreen<AddNewTaskScreen> {
  AddNewTaskViewModel addNewTaskViewModel = locator<AddNewTaskViewModel>();

  final GlobalKey<AddTaskFormWidgetState> _addTaskFormKey =
      GlobalKey<AddTaskFormWidgetState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => addNewTaskViewModel,
      child: Consumer<AddNewTaskViewModel>(
        builder: (context, addNewTaskViewModel, child) {
          return Scaffold(
            appBar: AppBarWidget(
              mTitle: getStringFromRes(AppLang.add_task_button),
            ),
            body: KeyboardDismisserWidget(
              child: Container(
                padding: const EdgeInsets.all(AppDimen.app_margin),
                child: _buildContentView(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContentView() {
    return Column(
      children: [
        Expanded(
          child: ListView(
            children: [
              AddTaskFormWidget(
                key: _addTaskFormKey,
                onSubmitData: _addNewTaskToDB,
              )
            ],
          ),
        ),
        AppButtonWidget(
          label: getStringFromRes(AppLang.add_task_button),
          onPressed: _validateData,
        )
      ],
    );
  }

  void _validateData() {
    _addTaskFormKey.currentState.validateInputs();
  }

  void _addNewTaskToDB(String name) async {
    var id = await addNewTaskViewModel.addNewTask(name);

    if (id > 0) {
      _updateReloadData();

      showSuccessDialog(
        content: getStringFromRes(AppLang.add_task_success),
        barrierDismissible: false,
        onClose: () {
          Navigator.of(context).pop();
        },
      );
    } else {
      showErrorDialog(
        content: getStringFromRes(AppLang.add_task_error),
      );
    }
  }

  void _updateReloadData() {
    var taskShareViewModel =
        Provider.of<TaskShareViewModel>(context, listen: false);
    taskShareViewModel
        .setReload([TaskListScreenType.ALL, TaskListScreenType.NEW]);
  }
}
