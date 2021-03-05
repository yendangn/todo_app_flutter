import 'package:flutter/material.dart';
import 'package:todoapp/resources/app_font.dart';
import 'package:todoapp/schema/task.dart';

class TaskItemWidget extends StatefulWidget {
  final Task task;
  final Function(TaskStatus) onUpdateTaskStatus;

  TaskItemWidget({
    @required this.task,
    this.onUpdateTaskStatus,
  }) : assert(task != null);

  @override
  _TaskItemWidgetState createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Checkbox(
            value: widget.task.status == TaskStatus.Completed,
            onChanged: (bool value) {
              if (widget.onUpdateTaskStatus != null) {
                widget.onUpdateTaskStatus(
                    value ? TaskStatus.Completed : TaskStatus.New);
              }
            },
          ),
          Expanded(
            child: Text(
              widget.task.name,
              style: TextStyle(
                fontSize: 15,
                fontFamily: AppFont.nunito_regular,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
