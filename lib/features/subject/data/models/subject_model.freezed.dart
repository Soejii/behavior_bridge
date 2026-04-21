// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subject_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SubjectModel _$SubjectModelFromJson(Map<String, dynamic> json) {
  return _SubjectModel.fromJson(json);
}

/// @nodoc
mixin _$SubjectModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get ageYears => throw _privateConstructorUsedError;
  String get relationship => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this SubjectModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of SubjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SubjectModelCopyWith<SubjectModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SubjectModelCopyWith<$Res> {
  factory $SubjectModelCopyWith(
          SubjectModel value, $Res Function(SubjectModel) then) =
      _$SubjectModelCopyWithImpl<$Res, SubjectModel>;
  @useResult
  $Res call(
      {String id,
      String name,
      int ageYears,
      String relationship,
      DateTime createdAt});
}

/// @nodoc
class _$SubjectModelCopyWithImpl<$Res, $Val extends SubjectModel>
    implements $SubjectModelCopyWith<$Res> {
  _$SubjectModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SubjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ageYears = null,
    Object? relationship = null,
    Object? createdAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ageYears: null == ageYears
          ? _value.ageYears
          : ageYears // ignore: cast_nullable_to_non_nullable
              as int,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SubjectModelImplCopyWith<$Res>
    implements $SubjectModelCopyWith<$Res> {
  factory _$$SubjectModelImplCopyWith(
          _$SubjectModelImpl value, $Res Function(_$SubjectModelImpl) then) =
      __$$SubjectModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      int ageYears,
      String relationship,
      DateTime createdAt});
}

/// @nodoc
class __$$SubjectModelImplCopyWithImpl<$Res>
    extends _$SubjectModelCopyWithImpl<$Res, _$SubjectModelImpl>
    implements _$$SubjectModelImplCopyWith<$Res> {
  __$$SubjectModelImplCopyWithImpl(
      _$SubjectModelImpl _value, $Res Function(_$SubjectModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of SubjectModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? ageYears = null,
    Object? relationship = null,
    Object? createdAt = null,
  }) {
    return _then(_$SubjectModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      ageYears: null == ageYears
          ? _value.ageYears
          : ageYears // ignore: cast_nullable_to_non_nullable
              as int,
      relationship: null == relationship
          ? _value.relationship
          : relationship // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _$SubjectModelImpl implements _SubjectModel {
  const _$SubjectModelImpl(
      {required this.id,
      required this.name,
      required this.ageYears,
      required this.relationship,
      required this.createdAt});

  factory _$SubjectModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SubjectModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final int ageYears;
  @override
  final String relationship;
  @override
  final DateTime createdAt;

  @override
  String toString() {
    return 'SubjectModel(id: $id, name: $name, ageYears: $ageYears, relationship: $relationship, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SubjectModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.ageYears, ageYears) ||
                other.ageYears == ageYears) &&
            (identical(other.relationship, relationship) ||
                other.relationship == relationship) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, ageYears, relationship, createdAt);

  /// Create a copy of SubjectModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SubjectModelImplCopyWith<_$SubjectModelImpl> get copyWith =>
      __$$SubjectModelImplCopyWithImpl<_$SubjectModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SubjectModelImplToJson(
      this,
    );
  }
}

abstract class _SubjectModel implements SubjectModel {
  const factory _SubjectModel(
      {required final String id,
      required final String name,
      required final int ageYears,
      required final String relationship,
      required final DateTime createdAt}) = _$SubjectModelImpl;

  factory _SubjectModel.fromJson(Map<String, dynamic> json) =
      _$SubjectModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  int get ageYears;
  @override
  String get relationship;
  @override
  DateTime get createdAt;

  /// Create a copy of SubjectModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SubjectModelImplCopyWith<_$SubjectModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
