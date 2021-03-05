import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:route_annotation/route_annotation.dart';
import 'package:todoapp/base/base_screen.dart';
import 'package:todoapp/base/di/locator.dart';
import 'package:todoapp/feature/add_new_task/add_new_task_screen.dart';
import 'package:todoapp/feature/main/main_screen_viewmodel.dart';
import 'package:todoapp/feature/task_list/task_list_screen.dart';
import 'package:todoapp/resources/app_color.dart';

@RoutePage(isInitialRoute: true)
class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends BaseScreen<MainScreen> {
  MainScreenViewModel mainScreenViewModel = locator<MainScreenViewModel>();

  int _selectedIndex = 0;

  final List<TaskListScreen> _screenTabs = [
    TaskListScreen(
      type: TaskListScreenType.ALL,
    ),
    TaskListScreen(
      type: TaskListScreenType.NEW,
    ),
    TaskListScreen(
      type: TaskListScreenType.COMPLETED,
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => mainScreenViewModel,
      child: Consumer<MainScreenViewModel>(
        builder: (context, mainScreenViewModel, child) {
          return Scaffold(
            body: IndexedStack(
              index: _selectedIndex,
              children: _screenTabs,
            ),
            bottomNavigationBar: _buildBottomNavigationBar(),
            floatingActionButton: _buildAddNewTaskWidget(),
          );
        },
      ),
    );
  }

  Widget _buildBottomNavigationBar() => BottomNavigationBar(
        selectedFontSize: 12,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: _getTabItems(),
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.tabActiveColor,
        onTap: _onTabChange,
      );

  List<BottomNavigationBarItem> _getTabItems() {
    return [
      _buildTabItem(Icons.border_all),
      _buildTabItem(Icons.auto_fix_high),
      _buildTabItem(Icons.done_all),
    ];
  }

  BottomNavigationBarItem _buildTabItem(IconData icon) {
    return BottomNavigationBarItem(
      icon: Icon(
        icon,
        color: AppColor.tabInActiveColor,
        size: 30,
      ),
      activeIcon: Icon(
        icon,
        color: AppColor.tabActiveColor,
        size: 30,
      ),
      label: '',
    );
  }

  void _onTabChange(int index) {
    if (index == _selectedIndex) {
      return;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildAddNewTaskWidget() => FloatingActionButton(
        backgroundColor: AppColor.mainColor,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        child: Icon(Icons.add),
        onPressed: _addNewTask,
      );

  void _addNewTask() async {
    AddNewTaskScreen.start(context);
  }
}
