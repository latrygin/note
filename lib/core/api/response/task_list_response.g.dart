// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskListResponse _$$_TaskListResponseFromJson(Map<String, dynamic> json) =>
    _$_TaskListResponse(
      status: json['status'] as String,
      revision: json['revision'] as int,
      list: (json['list'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TaskListResponseToJson(_$_TaskListResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'revision': instance.revision,
      'list': instance.list,
    };
