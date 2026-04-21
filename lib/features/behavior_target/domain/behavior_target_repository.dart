import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

abstract class BehaviorTargetRepository {
  Future<Result<List<BehaviorTargetEntity>>> getAll();
  Future<Result<List<BehaviorTargetEntity>>> getBySubject(String subjectId);
  Future<Result<BehaviorTargetEntity?>> getById(String id);
  Future<Result<BehaviorTargetEntity>> upsert(BehaviorTargetEntity target);
  Future<Result<Unit>> remove(String id);
}
