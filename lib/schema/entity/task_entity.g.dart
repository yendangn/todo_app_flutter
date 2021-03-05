// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) {
  return TaskEntity(
    id: json['id'] as int,
    name: json['name'] as String,
    createdAt: json['created_at'] == null
        ? null
        : DateTime.parse(json['created_at'] as String),
    status: json['status'] as String,
  );
}

Map<String, dynamic> _$TaskEntityToJson(TaskEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', instance.id);
  writeNotNull('name', instance.name);
  writeNotNull('created_at', instance.createdAt?.toIso8601String());
  writeNotNull('status', instance.status);
  return val;
}
