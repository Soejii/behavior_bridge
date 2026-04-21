import 'package:behavior_bridge/features/daily_log/domain/daily_log_repository.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class GetLogsByTargetUsecase {
  const GetLogsByTargetUsecase(this._repo);
  final DailyLogRepository _repo;
  Future<Result<List<DailyLogEntity>>> call(String targetId) =>
      _repo.getByTarget(targetId);
}

class GetLogForDateUsecase {
  const GetLogForDateUsecase(this._repo);
  final DailyLogRepository _repo;
  Future<Result<DailyLogEntity?>> call(String targetId, DateTime date) =>
      _repo.getForDate(targetId, date);
}

class UpsertLogUsecase {
  const UpsertLogUsecase(this._repo);
  final DailyLogRepository _repo;
  Future<Result<DailyLogEntity>> call(DailyLogEntity log) => _repo.upsert(log);
}
