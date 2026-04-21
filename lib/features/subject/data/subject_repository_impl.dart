import 'package:behavior_bridge/features/subject/data/datasource/subject_local_data_source.dart';
import 'package:behavior_bridge/features/subject/data/mappers/subject_mapper.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/domain/subject_repository.dart';
import 'package:behavior_bridge/shared/core/types/result.dart';

class SubjectRepositoryImpl implements SubjectRepository {
  const SubjectRepositoryImpl(this._local);
  final SubjectLocalDataSource _local;

  @override
  Future<Result<List<SubjectEntity>>> getAll() => guard(() async {
        final models = _local.readAll();
        return models.map((m) => m.toEntity()).toList(growable: false);
      });

  @override
  Future<Result<SubjectEntity>> upsert(SubjectEntity subject) => guard(() async {
        final saved = await _local.upsert(subject.toModel());
        return saved.toEntity();
      });

  @override
  Future<Result<Unit>> remove(String id) => guard(() async {
        await _local.remove(id);
        return const Unit();
      });
}
