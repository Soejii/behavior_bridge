// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reinforcement_schedule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReinforcementScheduleModel _$ReinforcementScheduleModelFromJson(
    Map<String, dynamic> json) {
  return _ReinforcementScheduleModel.fromJson(json);
}

/// @nodoc
mixin _$ReinforcementScheduleModel {
  String get id => throw _privateConstructorUsedError;
  String get targetId => throw _privateConstructorUsedError;
  ScheduleType get type => throw _privateConstructorUsedError;
  int get ratio => throw _privateConstructorUsedError;
  int get intervalMinutes => throw _privateConstructorUsedError;
  String get reinforcerDescription => throw _privateConstructorUsedError;
  DateTime get appliedAt => throw _privateConstructorUsedError;

  /// Serializes this ReinforcementScheduleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReinforcementScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReinforcementScheduleModelCopyWith<ReinforcementScheduleModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReinforcementScheduleModelCopyWith<$Res> {
  factory $ReinforcementScheduleModelCopyWith(ReinforcementScheduleModel value,
          $Res Function(ReinforcementScheduleModel) then) =
      _$ReinforcementScheduleModelCopyWithImpl<$Res,
          ReinforcementScheduleModel>;
  @useResult
  $Res call(
      {String id,
      String targetId,
      ScheduleType type,
      int ratio,
      int intervalMinutes,
      String reinforcerDescription,
      DateTime appliedAt});
}

/// @nodoc
class _$ReinforcementScheduleModelCopyWithImpl<$Res,
        $Val extends ReinforcementScheduleModel>
    implements $ReinforcementScheduleModelCopyWith<$Res> {
  _$ReinforcementScheduleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReinforcementScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetId = null,
    Object? type = null,
    Object? ratio = null,
    Object? intervalMinutes = null,
    Object? reinforcerDescription = null,
    Object? appliedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ScheduleType,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as int,
      intervalMinutes: null == intervalMinutes
          ? _value.intervalMinutes
          : intervalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      reinforcerDescription: null == reinforcerDescription
          ? _value.reinforcerDescription
          : reinforcerDescription // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReinforcementScheduleModelImplCopyWith<$Res>
    implements $ReinforcementScheduleModelCopyWith<$Res> {
  factory _$$ReinforcementScheduleModelImplCopyWith(
          _$ReinforcementScheduleModelImpl value,
          $Res Function(_$ReinforcementScheduleModelImpl) then) =
      __$$ReinforcementScheduleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String targetId,
      ScheduleType type,
      int ratio,
      int intervalMinutes,
      String reinforcerDescription,
      DateTime appliedAt});
}

/// @nodoc
class __$$ReinforcementScheduleModelImplCopyWithImpl<$Res>
    extends _$ReinforcementScheduleModelCopyWithImpl<$Res,
        _$ReinforcementScheduleModelImpl>
    implements _$$ReinforcementScheduleModelImplCopyWith<$Res> {
  __$$ReinforcementScheduleModelImplCopyWithImpl(
      _$ReinforcementScheduleModelImpl _value,
      $Res Function(_$ReinforcementScheduleModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReinforcementScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetId = null,
    Object? type = null,
    Object? ratio = null,
    Object? intervalMinutes = null,
    Object? reinforcerDescription = null,
    Object? appliedAt = null,
  }) {
    return _then(_$ReinforcementScheduleModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as ScheduleType,
      ratio: null == ratio
          ? _value.ratio
          : ratio // ignore: cast_nullable_to_non_nullable
              as int,
      intervalMinutes: null == intervalMinutes
          ? _value.intervalMinutes
          : intervalMinutes // ignore: cast_nullable_to_non_nullable
              as int,
      reinforcerDescription: null == reinforcerDescription
          ? _value.reinforcerDescription
          : reinforcerDescription // ignore: cast_nullable_to_non_nullable
              as String,
      appliedAt: null == appliedAt
          ? _value.appliedAt
          : appliedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$ReinforcementScheduleModelImpl implements _ReinforcementScheduleModel {
  const _$ReinforcementScheduleModelImpl(
      {required this.id,
      required this.targetId,
      required this.type,
      required this.ratio,
      required this.intervalMinutes,
      required this.reinforcerDescription,
      required this.appliedAt});

  factory _$ReinforcementScheduleModelImpl.fromJson(
          Map<String, dynamic> json) =>
      _$$ReinforcementScheduleModelImplFromJson(json);

  @override
  final String id;
  @override
  final String targetId;
  @override
  final ScheduleType type;
  @override
  final int ratio;
  @override
  final int intervalMinutes;
  @override
  final String reinforcerDescription;
  @override
  final DateTime appliedAt;

  @override
  String toString() {
    return 'ReinforcementScheduleModel(id: $id, targetId: $targetId, type: $type, ratio: $ratio, intervalMinutes: $intervalMinutes, reinforcerDescription: $reinforcerDescription, appliedAt: $appliedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReinforcementScheduleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.ratio, ratio) || other.ratio == ratio) &&
            (identical(other.intervalMinutes, intervalMinutes) ||
                other.intervalMinutes == intervalMinutes) &&
            (identical(other.reinforcerDescription, reinforcerDescription) ||
                other.reinforcerDescription == reinforcerDescription) &&
            (identical(other.appliedAt, appliedAt) ||
                other.appliedAt == appliedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, targetId, type, ratio,
      intervalMinutes, reinforcerDescription, appliedAt);

  /// Create a copy of ReinforcementScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReinforcementScheduleModelImplCopyWith<_$ReinforcementScheduleModelImpl>
      get copyWith => __$$ReinforcementScheduleModelImplCopyWithImpl<
          _$ReinforcementScheduleModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReinforcementScheduleModelImplToJson(
      this,
    );
  }
}

abstract class _ReinforcementScheduleModel
    implements ReinforcementScheduleModel {
  const factory _ReinforcementScheduleModel(
      {required final String id,
      required final String targetId,
      required final ScheduleType type,
      required final int ratio,
      required final int intervalMinutes,
      required final String reinforcerDescription,
      required final DateTime appliedAt}) = _$ReinforcementScheduleModelImpl;

  factory _ReinforcementScheduleModel.fromJson(Map<String, dynamic> json) =
      _$ReinforcementScheduleModelImpl.fromJson;

  @override
  String get id;
  @override
  String get targetId;
  @override
  ScheduleType get type;
  @override
  int get ratio;
  @override
  int get intervalMinutes;
  @override
  String get reinforcerDescription;
  @override
  DateTime get appliedAt;

  /// Create a copy of ReinforcementScheduleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReinforcementScheduleModelImplCopyWith<_$ReinforcementScheduleModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
