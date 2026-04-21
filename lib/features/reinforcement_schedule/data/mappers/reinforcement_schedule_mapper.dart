import 'package:behavior_bridge/features/reinforcement_schedule/data/models/reinforcement_schedule_model.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';

extension ReinforcementScheduleModelX on ReinforcementScheduleModel {
  ReinforcementScheduleEntity toEntity() => ReinforcementScheduleEntity(
        id: id,
        targetId: targetId,
        type: type,
        ratio: ratio,
        intervalMinutes: intervalMinutes,
        reinforcerDescription: reinforcerDescription,
        appliedAt: appliedAt,
      );
}

extension ReinforcementScheduleEntityX on ReinforcementScheduleEntity {
  ReinforcementScheduleModel toModel() => ReinforcementScheduleModel(
        id: id,
        targetId: targetId,
        type: type,
        ratio: ratio,
        intervalMinutes: intervalMinutes,
        reinforcerDescription: reinforcerDescription,
        appliedAt: appliedAt,
      );
}
