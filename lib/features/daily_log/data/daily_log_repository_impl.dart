import 'package:behavior_bridge/features/daily_log/data/datasource/daily_log_local_data_source.dart';
import 'package:behavior_bridge/features/daily_log/data/mappers/daily_log_mapper.dart';
import 'package:behavior_bridge/features/daily_log/domain/daily_log_repository.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class DailyLogRepositoryImpl implements DailyLogRepository {
  const DailyLogRepositoryImpl(this._local);
  final DailyLogLocalDataSource _local;

  @override
  Future<Result<List<DailyLogEntity>>> getByTarget(String targetId) =>
      guard(() async {
        final list = _local
            .readAll()
            .where((m) => m.targetId == targetId)
            .map((m) => m.toEntity())
            .toList(growable: true);
        list.sort((a, b) => a.date.compareTo(b.date));
        return list;
      });

  @override
  Future<Result<DailyLogEntity?>> getForDate(
          String targetId, DateTime date) =>
      guard(() async {
        final day = DateTime(date.year, date.month, date.day);
        final match = _local.readAll().where((m) =>
            m.targetId == targetId &&
            DateTime(m.date.year, m.date.month, m.date.day) == day);
        return match.isEmpty ? null : match.first.toEntity();
      });

  @override
  Future<Result<DailyLogEntity>> upsert(DailyLogEntity log) => guard(() async {
        final saved = await _local.upsert(log.toModel());
        return saved.toEntity();
      });

  @override
  Future<Result<Unit>> remove(String id) => guard(() async {
        await _local.remove(id);
        return const Unit();
      });
}
