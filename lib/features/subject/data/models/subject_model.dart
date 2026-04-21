import 'package:freezed_annotation/freezed_annotation.dart';

part 'subject_model.freezed.dart';
part 'subject_model.g.dart';

@freezed
class SubjectModel with _$SubjectModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory SubjectModel({
    required String id,
    required String name,
    required int ageYears,
    required String relationship,
    required DateTime createdAt,
  }) = _SubjectModel;

  factory SubjectModel.fromJson(Map<String, dynamic> json) =>
      _$SubjectModelFromJson(json);
}
