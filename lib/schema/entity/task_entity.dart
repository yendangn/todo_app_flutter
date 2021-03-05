import 'package:enum_to_string/enum_to_string.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todoapp/schema/task.dart';

part 'task_entity.g.dart';

@JsonSerializable()
class TaskEntity {
  int id;
  String name;
  @JsonKey(name: 'created_at')
  DateTime createdAt;
  String status;

  TaskEntity({
    this.id,
    this.name,
    this.createdAt,
    this.status,
  });

  static String tableName = 'task';

  factory TaskEntity.fromTask(Task task) => TaskEntity(
        id: task.id,
        name: task.name,
        createdAt: task.createdAt,
        status: EnumToString.convertToString(task.status),
      );

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);
}
