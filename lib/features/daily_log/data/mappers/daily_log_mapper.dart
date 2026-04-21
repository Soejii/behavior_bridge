import 'package:behavior_bridge/features/daily_log/data/models/daily_log_model.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';

extension DailyLogModelX on DailyLogModel {
  DailyLogEntity toEntity() => DailyLogEntity(
        id: id,
        targetId: targetId,
        date: date,
        occurrenceCount: occurrenceCount,
        reinforcementGiven: reinforcementGiven,
        notes: notes,
      );
}

extension DailyLogEntityX on DailyLogEntity {
  DailyLogModel toModel() => DailyLogModel(
        id: id,
        targetId: targetId,
        date: date,
        occurrenceCount: occurrenceCount,
        reinforcementGiven: reinforcementGiven,
        notes: notes,
      );
}
