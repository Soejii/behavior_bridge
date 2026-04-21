import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:behavior_bridge/features/reinforcement_schedule/data/datasource/reinforcement_schedule_local_data_source.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/data/reinforcement_schedule_repository_impl.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/reinforcement_schedule_repository.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/usecase/reinforcement_schedule_usecases.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

part 'reinforcement_schedule_providers.g.dart';

const _uuid = Uuid();

@riverpod
ReinforcementScheduleLocalDataSource reinforcementScheduleLocalDatasource(
        Ref ref) =>
    ReinforcementScheduleLocalDataSource(ref.watch(localStoreProvider));

@riverpod
ReinforcementScheduleRepository reinforcementScheduleRepository(Ref ref) =>
    ReinforcementScheduleRepositoryImpl(
      ref.watch(reinforcementScheduleLocalDatasourceProvider),
    );

@riverpod
GetSchedulesByTargetUsecase getSchedulesByTargetUsecase(Ref ref) =>
    GetSchedulesByTargetUsecase(
        ref.watch(reinforcementScheduleRepositoryProvider));

@riverpod
GetCurrentScheduleUsecase getCurrentScheduleUsecase(Ref ref) =>
    GetCurrentScheduleUsecase(
        ref.watch(reinforcementScheduleRepositoryProvider));

@riverpod
UpsertScheduleUsecase upsertScheduleUsecase(Ref ref) =>
    UpsertScheduleUsecase(ref.watch(reinforcementScheduleRepositoryProvider));

@riverpod
Future<List<ReinforcementScheduleEntity>> schedulesByTarget(
  Ref ref,
  String targetId,
) async {
  final res =
      await ref.read(getSchedulesByTargetUsecaseProvider).call(targetId);
  return res.fold((f) => throw f, (list) => list);
}

@riverpod
Future<ReinforcementScheduleEntity?> currentSchedule(
  Ref ref,
  String targetId,
) async {
  final res = await ref.read(getCurrentScheduleUsecaseProvider).call(targetId);
  return res.fold((f) => throw f, (s) => s);
}

@Riverpod(keepAlive: true)
class ReinforcementScheduleController
    extends _$ReinforcementScheduleController {
  @override
  FutureOr<void> build() => null;

  Future<ReinforcementScheduleEntity> apply({
    required String targetId,
    required ScheduleType type,
    required int ratio,
    required int intervalMinutes,
    required String reinforcerDescription,
  }) async {
    final entity = ReinforcementScheduleEntity(
      id: _uuid.v4(),
      targetId: targetId,
      type: type,
      ratio: ratio,
      intervalMinutes: intervalMinutes,
      reinforcerDescription: reinforcerDescription,
      appliedAt: DateTime.now(),
    );
    final res = await ref.read(upsertScheduleUsecaseProvider).call(entity);
    final saved = res.fold((f) => throw f, (s) => s);
    ref.invalidate(currentScheduleProvider(targetId));
    ref.invalidate(schedulesByTargetProvider(targetId));
    return saved;
  }
}
