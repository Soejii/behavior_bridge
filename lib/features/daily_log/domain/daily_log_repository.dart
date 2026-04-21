import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

abstract class DailyLogRepository {
  Future<Result<List<DailyLogEntity>>> getByTarget(String targetId);
  Future<Result<DailyLogEntity?>> getForDate(String targetId, DateTime date);
  Future<Result<DailyLogEntity>> upsert(DailyLogEntity log);
  Future<Result<Unit>> remove(String id);
}
