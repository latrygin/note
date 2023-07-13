// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskResponse _$TaskResponseFromJson(Map<String, dynamic> json) {
  return _TaskResponse.fromJson(json);
}

/// @nodoc
mixin _$TaskResponse {
  String get status => throw _privateConstructorUsedError;
  int get revision => throw _privateConstructorUsedError;
  Task get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskResponseCopyWith<TaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskResponseCopyWith<$Res> {
  factory $TaskResponseCopyWith(
          TaskResponse value, $Res Function(TaskResponse) then) =
      _$TaskResponseCopyWithImpl<$Res, TaskResponse>;
  @useResult
  $Res call({String status, int revision, Task element});
}

/// @nodoc
class _$TaskResponseCopyWithImpl<$Res, $Val extends TaskResponse>
    implements $TaskResponseCopyWith<$Res> {
  _$TaskResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? revision = null,
    Object? element = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      element: null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Task,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskResponseCopyWith<$Res>
    implements $TaskResponseCopyWith<$Res> {
  factory _$$_TaskResponseCopyWith(
          _$_TaskResponse value, $Res Function(_$_TaskResponse) then) =
      __$$_TaskResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String status, int revision, Task element});
}

/// @nodoc
class __$$_TaskResponseCopyWithImpl<$Res>
    extends _$TaskResponseCopyWithImpl<$Res, _$_TaskResponse>
    implements _$$_TaskResponseCopyWith<$Res> {
  __$$_TaskResponseCopyWithImpl(
      _$_TaskResponse _value, $Res Function(_$_TaskResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? revision = null,
    Object? element = null,
  }) {
    return _then(_$_TaskResponse(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      revision: null == revision
          ? _value.revision
          : revision // ignore: cast_nullable_to_non_nullable
              as int,
      element: null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskResponse implements _TaskResponse {
  const _$_TaskResponse(
      {required this.status, required this.revision, required this.element});

  factory _$_TaskResponse.fromJson(Map<String, dynamic> json) =>
      _$$_TaskResponseFromJson(json);

  @override
  final String status;
  @override
  final int revision;
  @override
  final Task element;

  @override
  String toString() {
    return 'TaskResponse(status: $status, revision: $revision, element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskResponse &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.revision, revision) ||
                other.revision == revision) &&
            (identical(other.element, element) || other.element == element));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status, revision, element);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskResponseCopyWith<_$_TaskResponse> get copyWith =>
      __$$_TaskResponseCopyWithImpl<_$_TaskResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskResponseToJson(
      this,
    );
  }
}

abstract class _TaskResponse implements TaskResponse {
  const factory _TaskResponse(
      {required final String status,
      required final int revision,
      required final Task element}) = _$_TaskResponse;

  factory _TaskResponse.fromJson(Map<String, dynamic> json) =
      _$_TaskResponse.fromJson;

  @override
  String get status;
  @override
  int get revision;
  @override
  Task get element;
  @override
  @JsonKey(ignore: true)
  _$$_TaskResponseCopyWith<_$_TaskResponse> get copyWith =>
      throw _privateConstructorUsedError;
}
