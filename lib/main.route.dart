// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// RouteGenerator
// **************************************************************************

import 'package:flutter/material.dart';
import 'package:todoapp/feature/add_new_task/add_new_task_screen.dart';
import 'package:todoapp/feature/main/main_screen.dart';

const ROUTE_ADD_NEW_TASK_SCREEN = 'add_new_task_screen';
const ROUTE_HOME = '/';

RouteFactory onGenerateRoute = (settings) => Map.fromEntries([
      ..._addNewTaskScreen.entries,
      ..._home.entries,
    ])[settings.name](settings);

Map<String, RouteFactory> _addNewTaskScreen = <String, RouteFactory>{
  'add_new_task_screen': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => AddNewTaskScreen(),
      ),
};
Map<String, RouteFactory> _home = <String, RouteFactory>{
  '/': (RouteSettings settings) => MaterialPageRoute(
        builder: (BuildContext context) => MainScreen(),
      ),
};
