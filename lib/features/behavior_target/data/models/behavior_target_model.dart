import 'package:freezed_annotation/freezed_annotation.dart';

part 'behavior_target_model.freezed.dart';
part 'behavior_target_model.g.dart';

@freezed
class BehaviorTargetModel with _$BehaviorTargetModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory BehaviorTargetModel({
    required String id,
    required String subjectId,
    required String label,
    required String description,
    required int baselineFrequency,
    required int goalFrequency,
    required bool isIncreasing,
    required DateTime startDate,
    required bool isActive,
  }) = _BehaviorTargetModel;

  factory BehaviorTargetModel.fromJson(Map<String, dynamic> json) =>
      _$BehaviorTargetModelFromJson(json);
}
