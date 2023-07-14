// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskRequest _$TaskRequestFromJson(Map<String, dynamic> json) {
  return _TaskRequest.fromJson(json);
}

/// @nodoc
mixin _$TaskRequest {
  Task get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskRequestCopyWith<TaskRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskRequestCopyWith<$Res> {
  factory $TaskRequestCopyWith(
          TaskRequest value, $Res Function(TaskRequest) then) =
      _$TaskRequestCopyWithImpl<$Res, TaskRequest>;
  @useResult
  $Res call({Task element});
}

/// @nodoc
class _$TaskRequestCopyWithImpl<$Res, $Val extends TaskRequest>
    implements $TaskRequestCopyWith<$Res> {
  _$TaskRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? element = null,
  }) {
    return _then(_value.copyWith(
      element: null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Task,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskRequestCopyWith<$Res>
    implements $TaskRequestCopyWith<$Res> {
  factory _$$_TaskRequestCopyWith(
          _$_TaskRequest value, $Res Function(_$_TaskRequest) then) =
      __$$_TaskRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Task element});
}

/// @nodoc
class __$$_TaskRequestCopyWithImpl<$Res>
    extends _$TaskRequestCopyWithImpl<$Res, _$_TaskRequest>
    implements _$$_TaskRequestCopyWith<$Res> {
  __$$_TaskRequestCopyWithImpl(
      _$_TaskRequest _value, $Res Function(_$_TaskRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? element = null,
  }) {
    return _then(_$_TaskRequest(
      element: null == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as Task,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskRequest implements _TaskRequest {
  const _$_TaskRequest({required this.element});

  factory _$_TaskRequest.fromJson(Map<String, dynamic> json) =>
      _$$_TaskRequestFromJson(json);

  @override
  final Task element;

  @override
  String toString() {
    return 'TaskRequest(element: $element)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskRequest &&
            (identical(other.element, element) || other.element == element));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, element);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskRequestCopyWith<_$_TaskRequest> get copyWith =>
      __$$_TaskRequestCopyWithImpl<_$_TaskRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskRequestToJson(
      this,
    );
  }
}

abstract class _TaskRequest implements TaskRequest {
  const factory _TaskRequest({required final Task element}) = _$_TaskRequest;

  factory _TaskRequest.fromJson(Map<String, dynamic> json) =
      _$_TaskRequest.fromJson;

  @override
  Task get element;
  @override
  @JsonKey(ignore: true)
  _$$_TaskRequestCopyWith<_$_TaskRequest> get copyWith =>
      throw _privateConstructorUsedError;
}
