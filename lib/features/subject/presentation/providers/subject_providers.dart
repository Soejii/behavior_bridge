import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:behavior_bridge/features/subject/data/datasource/subject_local_data_source.dart';
import 'package:behavior_bridge/features/subject/data/subject_repository_impl.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/domain/subject_repository.dart';
import 'package:behavior_bridge/features/subject/domain/usecase/subject_usecases.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

part 'subject_providers.g.dart';

const _uuid = Uuid();

@riverpod
SubjectLocalDataSource subjectLocalDatasource(Ref ref) =>
    SubjectLocalDataSource(ref.watch(localStoreProvider));

@riverpod
SubjectRepository subjectRepository(Ref ref) =>
    SubjectRepositoryImpl(ref.watch(subjectLocalDatasourceProvider));

@riverpod
GetSubjectsUsecase getSubjectsUsecase(Ref ref) =>
    GetSubjectsUsecase(ref.watch(subjectRepositoryProvider));

@riverpod
UpsertSubjectUsecase upsertSubjectUsecase(Ref ref) =>
    UpsertSubjectUsecase(ref.watch(subjectRepositoryProvider));

@riverpod
DeleteSubjectUsecase deleteSubjectUsecase(Ref ref) =>
    DeleteSubjectUsecase(ref.watch(subjectRepositoryProvider));

@Riverpod(keepAlive: true)
class SubjectListController extends _$SubjectListController {
  @override
  Future<List<SubjectEntity>> build() async {
    final res = await ref.read(getSubjectsUsecaseProvider).call();
    return res.fold((f) => throw f, (list) => list);
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final res = await ref.read(getSubjectsUsecaseProvider).call();
      return res.fold((f) => throw f, (list) => list);
    });
  }

  Future<SubjectEntity> create({
    required String name,
    required int ageYears,
    required String relationship,
  }) async {
    final entity = SubjectEntity(
      id: _uuid.v4(),
      name: name,
      ageYears: ageYears,
      relationship: relationship,
      createdAt: DateTime.now(),
    );
    final res = await ref.read(upsertSubjectUsecaseProvider).call(entity);
    final saved = res.fold((f) => throw f, (s) => s);
    await refresh();
    return saved;
  }

  Future<void> remove(String id) async {
    final res = await ref.read(deleteSubjectUsecaseProvider).call(id);
    res.fold((f) => throw f, (_) => null);
    await refresh();
  }
}
