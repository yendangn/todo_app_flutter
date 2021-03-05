import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todoapp/schema/entity/task_entity.dart';

part 'task.g.dart';

enum TaskStatus { New, Completed }

@JsonSerializable()
class Task {
  int id;
  String name;
  TaskStatus status;
  DateTime createdAt;

  Task({
    this.id,
    this.name,
    this.status,
    this.createdAt,
  });

  factory Task.fromTaskEntity(TaskEntity taskEntity) => Task(
        id: taskEntity.id,
        name: taskEntity.name,
        createdAt: taskEntity.createdAt,
        status: EnumToString.fromString(TaskStatus.values, taskEntity.status),
      );

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);
}
