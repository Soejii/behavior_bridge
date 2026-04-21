// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_log_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DailyLogModel _$DailyLogModelFromJson(Map<String, dynamic> json) {
  return _DailyLogModel.fromJson(json);
}

/// @nodoc
mixin _$DailyLogModel {
  String get id => throw _privateConstructorUsedError;
  String get targetId => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  int get occurrenceCount => throw _privateConstructorUsedError;
  bool get reinforcementGiven => throw _privateConstructorUsedError;
  String? get notes => throw _privateConstructorUsedError;

  /// Serializes this DailyLogModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyLogModelCopyWith<DailyLogModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyLogModelCopyWith<$Res> {
  factory $DailyLogModelCopyWith(
          DailyLogModel value, $Res Function(DailyLogModel) then) =
      _$DailyLogModelCopyWithImpl<$Res, DailyLogModel>;
  @useResult
  $Res call(
      {String id,
      String targetId,
      DateTime date,
      int occurrenceCount,
      bool reinforcementGiven,
      String? notes});
}

/// @nodoc
class _$DailyLogModelCopyWithImpl<$Res, $Val extends DailyLogModel>
    implements $DailyLogModelCopyWith<$Res> {
  _$DailyLogModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetId = null,
    Object? date = null,
    Object? occurrenceCount = null,
    Object? reinforcementGiven = null,
    Object? notes = freezed,
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
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      occurrenceCount: null == occurrenceCount
          ? _value.occurrenceCount
          : occurrenceCount // ignore: cast_nullable_to_non_nullable
              as int,
      reinforcementGiven: null == reinforcementGiven
          ? _value.reinforcementGiven
          : reinforcementGiven // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyLogModelImplCopyWith<$Res>
    implements $DailyLogModelCopyWith<$Res> {
  factory _$$DailyLogModelImplCopyWith(
          _$DailyLogModelImpl value, $Res Function(_$DailyLogModelImpl) then) =
      __$$DailyLogModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String targetId,
      DateTime date,
      int occurrenceCount,
      bool reinforcementGiven,
      String? notes});
}

/// @nodoc
class __$$DailyLogModelImplCopyWithImpl<$Res>
    extends _$DailyLogModelCopyWithImpl<$Res, _$DailyLogModelImpl>
    implements _$$DailyLogModelImplCopyWith<$Res> {
  __$$DailyLogModelImplCopyWithImpl(
      _$DailyLogModelImpl _value, $Res Function(_$DailyLogModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? targetId = null,
    Object? date = null,
    Object? occurrenceCount = null,
    Object? reinforcementGiven = null,
    Object? notes = freezed,
  }) {
    return _then(_$DailyLogModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      targetId: null == targetId
          ? _value.targetId
          : targetId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      occurrenceCount: null == occurrenceCount
          ? _value.occurrenceCount
          : occurrenceCount // ignore: cast_nullable_to_non_nullable
              as int,
      reinforcementGiven: null == reinforcementGiven
          ? _value.reinforcementGiven
          : reinforcementGiven // ignore: cast_nullable_to_non_nullable
              as bool,
      notes: freezed == notes
          ? _value.notes
          : notes // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$DailyLogModelImpl implements _DailyLogModel {
  const _$DailyLogModelImpl(
      {required this.id,
      required this.targetId,
      required this.date,
      required this.occurrenceCount,
      required this.reinforcementGiven,
      this.notes});

  factory _$DailyLogModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyLogModelImplFromJson(json);

  @override
  final String id;
  @override
  final String targetId;
  @override
  final DateTime date;
  @override
  final int occurrenceCount;
  @override
  final bool reinforcementGiven;
  @override
  final String? notes;

  @override
  String toString() {
    return 'DailyLogModel(id: $id, targetId: $targetId, date: $date, occurrenceCount: $occurrenceCount, reinforcementGiven: $reinforcementGiven, notes: $notes)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyLogModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.targetId, targetId) ||
                other.targetId == targetId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.occurrenceCount, occurrenceCount) ||
                other.occurrenceCount == occurrenceCount) &&
            (identical(other.reinforcementGiven, reinforcementGiven) ||
                other.reinforcementGiven == reinforcementGiven) &&
            (identical(other.notes, notes) || other.notes == notes));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, targetId, date,
      occurrenceCount, reinforcementGiven, notes);

  /// Create a copy of DailyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyLogModelImplCopyWith<_$DailyLogModelImpl> get copyWith =>
      __$$DailyLogModelImplCopyWithImpl<_$DailyLogModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyLogModelImplToJson(
      this,
    );
  }
}

abstract class _DailyLogModel implements DailyLogModel {
  const factory _DailyLogModel(
      {required final String id,
      required final String targetId,
      required final DateTime date,
      required final int occurrenceCount,
      required final bool reinforcementGiven,
      final String? notes}) = _$DailyLogModelImpl;

  factory _DailyLogModel.fromJson(Map<String, dynamic> json) =
      _$DailyLogModelImpl.fromJson;

  @override
  String get id;
  @override
  String get targetId;
  @override
  DateTime get date;
  @override
  int get occurrenceCount;
  @override
  bool get reinforcementGiven;
  @override
  String? get notes;

  /// Create a copy of DailyLogModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyLogModelImplCopyWith<_$DailyLogModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
