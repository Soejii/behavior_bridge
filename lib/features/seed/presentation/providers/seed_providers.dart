import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/providers/reinforcement_schedule_providers.dart';
import 'package:behavior_bridge/features/seed/domain/usecase/seed_usecase.dart';
import 'package:behavior_bridge/features/subject/presentation/providers/subject_providers.dart';

part 'seed_providers.g.dart';

@riverpod
SeedUsecase seedUsecase(Ref ref) => SeedUsecase(
      subjects: ref.watch(subjectRepositoryProvider),
      targets: ref.watch(behaviorTargetRepositoryProvider),
      schedules: ref.watch(reinforcementScheduleRepositoryProvider),
      logs: ref.watch(dailyLogRepositoryProvider),
    );
