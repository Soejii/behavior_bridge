import 'package:behavior_bridge/features/behavior_target/data/datasource/behavior_target_local_data_source.dart';
import 'package:behavior_bridge/features/behavior_target/data/mappers/behavior_target_mapper.dart';
import 'package:behavior_bridge/features/behavior_target/domain/behavior_target_repository.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class BehaviorTargetRepositoryImpl implements BehaviorTargetRepository {
  const BehaviorTargetRepositoryImpl(this._local);
  final BehaviorTargetLocalDataSource _local;

  @override
  Future<Result<List<BehaviorTargetEntity>>> getAll() => guard(() async {
        return _local.readAll().map((m) => m.toEntity()).toList(growable: false);
      });

  @override
  Future<Result<List<BehaviorTargetEntity>>> getBySubject(String subjectId) =>
      guard(() async {
        return _local
            .readAll()
            .where((m) => m.subjectId == subjectId)
            .map((m) => m.toEntity())
            .toList(growable: false);
      });

  @override
  Future<Result<BehaviorTargetEntity?>> getById(String id) => guard(() async {
        final all = _local.readAll();
        final match = all.where((e) => e.id == id);
        return match.isEmpty ? null : match.first.toEntity();
      });

  @override
  Future<Result<BehaviorTargetEntity>> upsert(BehaviorTargetEntity target) =>
      guard(() async {
        final saved = await _local.upsert(target.toModel());
        return saved.toEntity();
      });

  @override
  Future<Result<Unit>> remove(String id) => guard(() async {
        await _local.remove(id);
        return const Unit();
      });
}
