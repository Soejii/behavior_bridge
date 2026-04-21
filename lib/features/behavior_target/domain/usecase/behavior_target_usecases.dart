import 'package:behavior_bridge/features/behavior_target/domain/behavior_target_repository.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class GetTargetsBySubjectUsecase {
  const GetTargetsBySubjectUsecase(this._repo);
  final BehaviorTargetRepository _repo;
  Future<Result<List<BehaviorTargetEntity>>> call(String subjectId) =>
      _repo.getBySubject(subjectId);
}

class GetTargetByIdUsecase {
  const GetTargetByIdUsecase(this._repo);
  final BehaviorTargetRepository _repo;
  Future<Result<BehaviorTargetEntity?>> call(String id) => _repo.getById(id);
}

class UpsertTargetUsecase {
  const UpsertTargetUsecase(this._repo);
  final BehaviorTargetRepository _repo;
  Future<Result<BehaviorTargetEntity>> call(BehaviorTargetEntity t) =>
      _repo.upsert(t);
}

class DeleteTargetUsecase {
  const DeleteTargetUsecase(this._repo);
  final BehaviorTargetRepository _repo;
  Future<Result<Unit>> call(String id) => _repo.remove(id);
}
