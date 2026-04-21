import 'package:behavior_bridge/features/reinforcement_schedule/data/datasource/reinforcement_schedule_local_data_source.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/data/mappers/reinforcement_schedule_mapper.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/reinforcement_schedule_repository.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class ReinforcementScheduleRepositoryImpl
    implements ReinforcementScheduleRepository {
  const ReinforcementScheduleRepositoryImpl(this._local);
  final ReinforcementScheduleLocalDataSource _local;

  @override
  Future<Result<List<ReinforcementScheduleEntity>>> getByTarget(
          String targetId) =>
      guard(() async {
        return _local
            .readAll()
            .where((m) => m.targetId == targetId)
            .map((m) => m.toEntity())
            .toList(growable: false);
      });

  @override
  Future<Result<ReinforcementScheduleEntity?>> getCurrentForTarget(
          String targetId) =>
      guard(() async {
        final all = _local
            .readAll()
            .where((m) => m.targetId == targetId)
            .toList(growable: false);
        if (all.isEmpty) return null;
        all.sort((a, b) => b.appliedAt.compareTo(a.appliedAt));
        return all.first.toEntity();
      });

  @override
  Future<Result<ReinforcementScheduleEntity>> upsert(
          ReinforcementScheduleEntity schedule) =>
      guard(() async {
        final saved = await _local.upsert(schedule.toModel());
        return saved.toEntity();
      });

  @override
  Future<Result<Unit>> remove(String id) => guard(() async {
        await _local.remove(id);
        return const Unit();
      });
}
