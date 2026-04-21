import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

abstract class SubjectRepository {
  Future<Result<List<SubjectEntity>>> getAll();
  Future<Result<SubjectEntity>> upsert(SubjectEntity subject);
  Future<Result<Unit>> remove(String id);
}
