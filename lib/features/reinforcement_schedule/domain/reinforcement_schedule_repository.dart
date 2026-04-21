import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

abstract class ReinforcementScheduleRepository {
  Future<Result<List<ReinforcementScheduleEntity>>> getByTarget(String targetId);
  Future<Result<ReinforcementScheduleEntity?>> getCurrentForTarget(
      String targetId);
  Future<Result<ReinforcementScheduleEntity>> upsert(
      ReinforcementScheduleEntity schedule);
  Future<Result<Unit>> remove(String id);
}
