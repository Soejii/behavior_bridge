import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/analysis/presentation/providers/analysis_providers.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/providers/reinforcement_schedule_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/widgets/progress_chart_widget.dart';
import 'package:behavior_bridge/shared/widgets/stat_card_widget.dart';
import 'package:behavior_bridge/shared/widgets/suggestion_card_widget.dart';

class DashboardLayoutScreen extends ConsumerWidget {
  const DashboardLayoutScreen({
    super.key,
    required this.subjectId,
    this.targetId,
  });

  final String subjectId;
  final String? targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final targetsAsync = ref.watch(targetsBySubjectProvider(subjectId));
    final targets = targetsAsync.valueOrNull ?? [];
    
    final effectiveTargetId = targetId ?? (targets.isNotEmpty ? targets.first.id : null);

    final targetAsync = effectiveTargetId != null ? ref.watch(targetByIdProvider(effectiveTargetId)) : const AsyncValue.data(null);
    final logsAsync = effectiveTargetId != null ? ref.watch(logsByTargetProvider(effectiveTargetId)) : const AsyncValue.data(<DailyLogEntity>[]);
    final analysisAsync = effectiveTargetId != null ? ref.watch(analysisProvider(effectiveTargetId)) : const AsyncValue.loading();
    final scheduleAsync = effectiveTargetId != null ? ref.watch(currentScheduleProvider(effectiveTargetId)) : const AsyncValue.data(null);

    final target = targetAsync.valueOrNull;
    final logs = logsAsync.valueOrNull ?? [];
    final values = logs.map((l) => l.occurrenceCount).toList(growable: false);
    final schedule = scheduleAsync.valueOrNull;

    final scheduleChanges = <int>[];
    if (schedule != null && logs.isNotEmpty) {
      for (var i = 0; i < logs.length; i++) {
        if (!logs[i].date.isBefore(schedule.appliedAt) &&
            (i == 0 || logs[i - 1].date.isBefore(schedule.appliedAt))) {
          scheduleChanges.add(i);
        }
      }
    }

    return Scaffold(
      backgroundColor: b.bg,
      body: Row(
        children: [
          _Sidebar(subjectId: subjectId, targetId: effectiveTargetId),
          Expanded(
            flex: 3,
            child: effectiveTargetId == null 
              ? Center(child: Text('No targets yet', style: TextStyle(color: b.ink3)))
              : Column(
              children: [
                Container(
                  height: 72.h,
                  padding: EdgeInsets.symmetric(horizontal: 28.w),
                  decoration: BoxDecoration(
                    color: b.card,
                    border: Border(bottom: BorderSide(color: b.line)),
                  ),
                  child: Row(
                    children: [
                      if (target != null)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Behavior target',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 11.sp,
                                color: b.ink3,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              target.label,
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w700,
                                fontSize: 20.sp,
                                letterSpacing: -0.3,
                                color: b.ink,
                              ),
                            ),
                          ],
                        ),
                      const Spacer(),
                      FilledButton.icon(
                        style: FilledButton.styleFrom(
                          backgroundColor: b.accent,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                        ),
                        onPressed: () => context.goNamed(
                          RouteName.dailyLog,
                          pathParameters: {'targetId': effectiveTargetId},
                        ),
                        icon: Icon(Icons.check, size: 16.r, color: Colors.white),
                        label: Text(
                          'Log today',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w600,
                            fontSize: 13.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(28.w),
                    children: [
                      if (target != null)
                        GridView.count(
                          crossAxisCount: 5,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          crossAxisSpacing: 12.w,
                          childAspectRatio: 1.2,
                          children: [
                            StatCardWidget(label: 'Goal', value: '${target.goalFrequency}×/day', hint: 'Increase'),
                            StatCardWidget(label: 'Baseline', value: '${target.baselineFrequency}×/day', hint: 'Start'),
                            StatCardWidget(label: 'Avg/day', value: _avg(values, values.length).toStringAsFixed(1), hint: 'Last ${values.length}d'),
                            StatCardWidget(label: 'At goal', value: '${values.where((v) => v >= target.goalFrequency).length}d', hint: 'of ${values.length}d logged'),
                            StatCardWidget(label: 'Schedule', value: schedule?.type.shortLabel ?? 'CRF', hint: 'Current'),
                          ],
                        ),
                      SizedBox(height: 20.h),
                      Container(
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color: b.card,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: b.line),
                          boxShadow: b.sh1,
                        ),
                        child: ProgressChartWidget(
                          values: values,
                          goal: target?.goalFrequency ?? 4,
                          height: 240,
                          scheduleChanges: scheduleChanges,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 280.w,
            decoration: BoxDecoration(
              color: b.card,
              border: Border(left: BorderSide(color: b.line)),
            ),
            child: effectiveTargetId == null 
              ? const SizedBox()
              : ListView(
              padding: EdgeInsets.all(16.w),
              children: [
                Text(
                  'Recommendation',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: b.ink3,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(height: 10.h),
                analysisAsync.when(
                  loading: () => Center(
                    child: CircularProgressIndicator(
                      color: b.accent,
                      strokeWidth: 2,
                    ),
                  ),
                  error: (e, _) => Text(
                    '$e',
                    style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12.sp,
                        color: b.risk),
                  ),
                  data: (r) => SuggestionCardWidget(result: r),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static double _avg(List<int> values, int n) {
    if (values.isEmpty) return 0;
    final slice =
        values.length > n ? values.sublist(values.length - n) : values;
    return slice.reduce((a, b) => a + b) / slice.length;
  }
}

class _Sidebar extends ConsumerWidget {
  const _Sidebar({required this.subjectId, this.targetId});
  final String subjectId;
  final String? targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final targetsAsync = ref.watch(targetsBySubjectProvider(subjectId));
    return Container(
      width: 220.w,
      decoration: BoxDecoration(
        color: b.bg,
        border: Border(right: BorderSide(color: b.line)),
      ),
      child: Column(
        children: [
          Container(
            height: 56.h,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: b.line)),
            ),
            child: Row(
              children: [
                Container(
                  width: 28.r,
                  height: 28.r,
                  decoration: BoxDecoration(
                    color: b.accent,
                    borderRadius: BorderRadius.circular(7.r),
                  ),
                  child: Center(
                    child: Text(
                      'BB',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w800,
                        fontSize: 10.sp,
                        color: b.card,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.w),
                Text(
                  'BehaviorBridge',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w700,
                    fontSize: 13.sp,
                    color: b.ink,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: targetsAsync.when(
              loading: () => const SizedBox(),
              error: (_, __) => const SizedBox(),
              data: (targets) => ListView(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                children: targets.map((t) {
                  final active = t.id == targetId;
                  return GestureDetector(
                    onTap: () => context.goNamed(
                      RouteName.subjectDetail,
                      pathParameters: {'subjectId': subjectId},
                      queryParameters: {'targetId': t.id},
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 14.w,
                        vertical: 10.h,
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 2.h,
                      ),
                      decoration: BoxDecoration(
                        color: active ? b.accentTint : Colors.transparent,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        t.label,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13.sp,
                          fontWeight: active
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: active ? b.accentFg : b.ink2,
                        ),
                      ),
                    ),
                  );
                }).toList(growable: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
