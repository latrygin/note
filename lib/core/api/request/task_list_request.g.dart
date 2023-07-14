// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_TaskRequest _$$_TaskRequestFromJson(Map<String, dynamic> json) =>
    _$_TaskRequest(
      list: (json['list'] as List<dynamic>)
          .map((e) => Task.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_TaskRequestToJson(_$_TaskRequest instance) =>
    <String, dynamic>{
      'list': instance.list,
    };
