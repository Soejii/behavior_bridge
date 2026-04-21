import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:behavior_bridge/features/behavior_target/data/behavior_target_repository_impl.dart';
import 'package:behavior_bridge/features/behavior_target/data/datasource/behavior_target_local_data_source.dart';
import 'package:behavior_bridge/features/behavior_target/domain/behavior_target_repository.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/features/behavior_target/domain/usecase/behavior_target_usecases.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

part 'behavior_target_providers.g.dart';

const _uuid = Uuid();

@riverpod
BehaviorTargetLocalDataSource behaviorTargetLocalDatasource(Ref ref) =>
    BehaviorTargetLocalDataSource(ref.watch(localStoreProvider));

@riverpod
BehaviorTargetRepository behaviorTargetRepository(Ref ref) =>
    BehaviorTargetRepositoryImpl(
      ref.watch(behaviorTargetLocalDatasourceProvider),
    );

@riverpod
GetTargetsBySubjectUsecase getTargetsBySubjectUsecase(Ref ref) =>
    GetTargetsBySubjectUsecase(ref.watch(behaviorTargetRepositoryProvider));

@riverpod
GetTargetByIdUsecase getTargetByIdUsecase(Ref ref) =>
    GetTargetByIdUsecase(ref.watch(behaviorTargetRepositoryProvider));

@riverpod
UpsertTargetUsecase upsertTargetUsecase(Ref ref) =>
    UpsertTargetUsecase(ref.watch(behaviorTargetRepositoryProvider));

@riverpod
DeleteTargetUsecase deleteTargetUsecase(Ref ref) =>
    DeleteTargetUsecase(ref.watch(behaviorTargetRepositoryProvider));

@riverpod
Future<List<BehaviorTargetEntity>> targetsBySubject(
  Ref ref,
  String subjectId,
) async {
  final res = await ref.read(getTargetsBySubjectUsecaseProvider).call(subjectId);
  return res.fold((f) => throw f, (list) => list);
}

@riverpod
Future<BehaviorTargetEntity?> targetById(Ref ref, String id) async {
  final res = await ref.read(getTargetByIdUsecaseProvider).call(id);
  return res.fold((f) => throw f, (t) => t);
}

@Riverpod(keepAlive: true)
class BehaviorTargetController extends _$BehaviorTargetController {
  @override
  FutureOr<void> build() => null;

  Future<BehaviorTargetEntity> create({
    required String subjectId,
    required String label,
    required String description,
    required int baselineFrequency,
    required int goalFrequency,
    required bool isIncreasing,
  }) async {
    final entity = BehaviorTargetEntity(
      id: _uuid.v4(),
      subjectId: subjectId,
      label: label,
      description: description,
      baselineFrequency: baselineFrequency,
      goalFrequency: goalFrequency,
      isIncreasing: isIncreasing,
      startDate: DateTime.now(),
      isActive: true,
    );
    final res = await ref.read(upsertTargetUsecaseProvider).call(entity);
    final saved = res.fold((f) => throw f, (t) => t);
    ref.invalidate(targetsBySubjectProvider(subjectId));
    return saved;
  }

  Future<void> deactivate(BehaviorTargetEntity target) async {
    final updated = target.copyWith(isActive: false);
    final res = await ref.read(upsertTargetUsecaseProvider).call(updated);
    res.fold((f) => throw f, (_) => null);
    ref.invalidate(targetsBySubjectProvider(target.subjectId));
  }

  Future<void> remove(BehaviorTargetEntity target) async {
    final res = await ref.read(deleteTargetUsecaseProvider).call(target.id);
    res.fold((f) => throw f, (_) => null);
    ref.invalidate(targetsBySubjectProvider(target.subjectId));
  }
}
