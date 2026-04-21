import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/providers/reinforcement_schedule_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/error_screen.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';
import 'package:behavior_bridge/shared/widgets/progress_chart_widget.dart';
import 'package:behavior_bridge/shared/widgets/stat_card_widget.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key, required this.targetId});
  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetAsync = ref.watch(targetByIdProvider(targetId));
    final logsAsync = ref.watch(logsByTargetProvider(targetId));
    final scheduleAsync = ref.watch(currentScheduleProvider(targetId));
    final b = context.brand;
    final l = AppLocalizations.of(context)!;

    if (targetAsync.isLoading || logsAsync.isLoading) {
      return const LoadingScreen();
    }
    if (targetAsync.hasError) return ErrorScreen(error: targetAsync.error!);
    if (logsAsync.hasError) return ErrorScreen(error: logsAsync.error!);

    final target = targetAsync.value;
    if (target == null) {
      return Scaffold(
        body: Center(
          child: Text(
            l.targetNotFound,
            style: TextStyle(fontFamily: 'Inter', color: b.ink3),
          ),
        ),
      );
    }

    final logs = logsAsync.valueOrNull ?? [];
    final schedule = scheduleAsync.valueOrNull;
    final values = logs.map((l) => l.occurrenceCount).toList(growable: false);

    final scheduleChanges = <int>[];
    if (schedule != null && logs.isNotEmpty) {
      for (var i = 0; i < logs.length; i++) {
        if (!logs[i].date.isBefore(schedule.appliedAt) &&
            (i == 0 || logs[i - 1].date.isBefore(schedule.appliedAt))) {
          scheduleChanges.add(i);
        }
      }
    }

    final avg =
        values.isEmpty ? 0.0 : values.reduce((a, b) => a + b) / values.length;
    final last7 =
        values.length >= 7 ? values.sublist(values.length - 7) : values;
    final avg7 =
        last7.isEmpty ? 0.0 : last7.reduce((a, b) => a + b) / last7.length;

    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(
        title: target.label,
        subtitle: l.daysLogged(logs.length),
        actions: [
          TextButton(
            onPressed: () => context.pushNamed(
              RouteName.suggestion,
              pathParameters: {'targetId': targetId},
            ),
            child: Text(
              l.analyse,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: b.accent,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: b.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: b.line),
              boxShadow: b.sh1,
            ),
            child: ProgressChartWidget(
              values: values,
              goal: target.goalFrequency,
              scheduleChanges: scheduleChanges,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: StatCardWidget(
                  label: l.sevenDayAvg,
                  value: avg7.toStringAsFixed(1),
                  hint: l.goalHint(target.goalFrequency),
                  emphasize: avg7 >= target.goalFrequency,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatCardWidget(
                  label: l.allTimeAvg,
                  value: avg.toStringAsFixed(1),
                  hint: l.sessions(logs.length),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: StatCardWidget(
                  label: l.daysLoggedLabel,
                  value: '${logs.length}',
                  hint: schedule != null ? schedule.type.shortLabel : 'CRF',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: b.accent,
              minimumSize: const Size.fromHeight(44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => context.pushNamed(
              RouteName.dailyLog,
              pathParameters: {'targetId': targetId},
            ),
            child: Text(
              l.logToday,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
