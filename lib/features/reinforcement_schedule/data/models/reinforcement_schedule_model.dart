import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';

part 'reinforcement_schedule_model.freezed.dart';
part 'reinforcement_schedule_model.g.dart';

@freezed
class ReinforcementScheduleModel with _$ReinforcementScheduleModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ReinforcementScheduleModel({
    required String id,
    required String targetId,
    required ScheduleType type,
    required int ratio,
    required int intervalMinutes,
    required String reinforcerDescription,
    required DateTime appliedAt,
  }) = _ReinforcementScheduleModel;

  factory ReinforcementScheduleModel.fromJson(Map<String, dynamic> json) =>
      _$ReinforcementScheduleModelFromJson(json);
}
