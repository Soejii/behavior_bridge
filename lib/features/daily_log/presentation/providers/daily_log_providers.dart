import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

import 'package:behavior_bridge/features/daily_log/data/daily_log_repository_impl.dart';
import 'package:behavior_bridge/features/daily_log/data/datasource/daily_log_local_data_source.dart';
import 'package:behavior_bridge/features/daily_log/domain/daily_log_repository.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/features/daily_log/domain/usecase/daily_log_usecases.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

part 'daily_log_providers.g.dart';

const _uuid = Uuid();

@riverpod
DailyLogLocalDataSource dailyLogLocalDatasource(Ref ref) =>
    DailyLogLocalDataSource(ref.watch(localStoreProvider));

@riverpod
DailyLogRepository dailyLogRepository(Ref ref) =>
    DailyLogRepositoryImpl(ref.watch(dailyLogLocalDatasourceProvider));

@riverpod
GetLogsByTargetUsecase getLogsByTargetUsecase(Ref ref) =>
    GetLogsByTargetUsecase(ref.watch(dailyLogRepositoryProvider));

@riverpod
GetLogForDateUsecase getLogForDateUsecase(Ref ref) =>
    GetLogForDateUsecase(ref.watch(dailyLogRepositoryProvider));

@riverpod
UpsertLogUsecase upsertLogUsecase(Ref ref) =>
    UpsertLogUsecase(ref.watch(dailyLogRepositoryProvider));

@riverpod
Future<List<DailyLogEntity>> logsByTarget(Ref ref, String targetId) async {
  final res = await ref.read(getLogsByTargetUsecaseProvider).call(targetId);
  return res.fold((f) => throw f, (list) => list);
}

@riverpod
Future<DailyLogEntity?> logForTargetToday(Ref ref, String targetId) async {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final res =
      await ref.read(getLogForDateUsecaseProvider).call(targetId, today);
  return res.fold((f) => throw f, (l) => l);
}

@Riverpod(keepAlive: true)
class DailyLogController extends _$DailyLogController {
  @override
  FutureOr<void> build() => null;

  Future<DailyLogEntity> upsertToday({
    required String targetId,
    required int occurrenceCount,
    required bool reinforcementGiven,
    String? notes,
  }) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final existingRes =
        await ref.read(getLogForDateUsecaseProvider).call(targetId, today);
    final existing = existingRes.fold((f) => throw f, (l) => l);
    final entity = (existing ??
            DailyLogEntity(
              id: _uuid.v4(),
              targetId: targetId,
              date: today,
              occurrenceCount: 0,
              reinforcementGiven: false,
            ))
        .copyWith(
      occurrenceCount: occurrenceCount,
      reinforcementGiven: reinforcementGiven,
      notes: notes,
    );
    final res = await ref.read(upsertLogUsecaseProvider).call(entity);
    final saved = res.fold((f) => throw f, (l) => l);
    ref.invalidate(logForTargetTodayProvider(targetId));
    ref.invalidate(logsByTargetProvider(targetId));
    return saved;
  }
}
