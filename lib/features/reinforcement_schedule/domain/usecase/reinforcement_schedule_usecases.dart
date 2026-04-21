import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/reinforcement_schedule_repository.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class GetSchedulesByTargetUsecase {
  const GetSchedulesByTargetUsecase(this._repo);
  final ReinforcementScheduleRepository _repo;
  Future<Result<List<ReinforcementScheduleEntity>>> call(String targetId) =>
      _repo.getByTarget(targetId);
}

class GetCurrentScheduleUsecase {
  const GetCurrentScheduleUsecase(this._repo);
  final ReinforcementScheduleRepository _repo;
  Future<Result<ReinforcementScheduleEntity?>> call(String targetId) =>
      _repo.getCurrentForTarget(targetId);
}

class UpsertScheduleUsecase {
  const UpsertScheduleUsecase(this._repo);
  final ReinforcementScheduleRepository _repo;
  Future<Result<ReinforcementScheduleEntity>> call(
          ReinforcementScheduleEntity s) =>
      _repo.upsert(s);
}
