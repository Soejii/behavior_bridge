import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:behavior_bridge/features/analysis/domain/entities/analysis_result.dart';
import 'package:behavior_bridge/features/analysis/domain/usecase/behavior_analysis_engine.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/providers/reinforcement_schedule_providers.dart';

part 'analysis_providers.g.dart';

@riverpod
BehaviorAnalysisEngine behaviorAnalysisEngine(Ref ref) =>
    const BehaviorAnalysisEngine();

@riverpod
Future<AnalysisResult> analysis(Ref ref, String targetId) async {
  final target = await ref.watch(targetByIdProvider(targetId).future);
  if (target == null) {
    throw StateError('Target $targetId not found');
  }
  final logs = await ref.watch(logsByTargetProvider(targetId).future);
  final schedule = await ref.watch(currentScheduleProvider(targetId).future);
  final engine = ref.watch(behaviorAnalysisEngineProvider);
  return engine.run(
    target: target,
    logs: logs,
    currentSchedule: schedule,
  );
}
