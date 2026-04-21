import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/domain/subject_repository.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class GetSubjectsUsecase {
  const GetSubjectsUsecase(this._repo);
  final SubjectRepository _repo;
  Future<Result<List<SubjectEntity>>> call() => _repo.getAll();
}

class UpsertSubjectUsecase {
  const UpsertSubjectUsecase(this._repo);
  final SubjectRepository _repo;
  Future<Result<SubjectEntity>> call(SubjectEntity subject) =>
      _repo.upsert(subject);
}

class DeleteSubjectUsecase {
  const DeleteSubjectUsecase(this._repo);
  final SubjectRepository _repo;
  Future<Result<Unit>> call(String id) => _repo.remove(id);
}
