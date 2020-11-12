// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoData _$_$TodoDataFromJson(Map<String, dynamic> json) {
  return _$TodoData(
    id: json['id'] as String,
    title: json['title'] as String,
    completed: json['completed'] as bool ?? false,
  );
}

Map<String, dynamic> _$_$TodoDataToJson(_$TodoData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'completed': instance.completed,
    };
