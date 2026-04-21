import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/error_screen.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';
import 'package:behavior_bridge/shared/widgets/pill_widget.dart';
import 'package:behavior_bridge/shared/widgets/progress_sparkline_widget.dart';

class SubjectDetailScreen extends ConsumerWidget {
  const SubjectDetailScreen({super.key, required this.subjectId});
  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetsAsync = ref.watch(targetsBySubjectProvider(subjectId));
    final b = context.brand;
    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(
        title: 'Targets',
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: b.accent, size: 22.r),
            onPressed: () => context.goNamed(
              RouteName.createTarget,
              pathParameters: {'subjectId': subjectId},
            ),
          ),
        ],
      ),
      body: targetsAsync.when(
        loading: () => const LoadingScreen(),
        error: (e, _) => ErrorScreen(error: e),
        data: (targets) => targets.isEmpty
            ? _emptyTargets(context, subjectId)
            : ListView.separated(
                padding: EdgeInsets.all(16.w),
                itemCount: targets.length,
                separatorBuilder: (_, __) => SizedBox(height: 10.h),
                itemBuilder: (_, i) => _TargetCard(target: targets[i]),
              ),
      ),
    );
  }

  Widget _emptyTargets(BuildContext context, String subjectId) {
    final b = context.brand;
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.track_changes, size: 48.r, color: b.accent),
            SizedBox(height: 12.h),
            Text(
              'No targets yet',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 17.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Add a behavior to track.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                color: b.ink3,
              ),
            ),
            SizedBox(height: 20.h),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: b.accent),
              onPressed: () => context.goNamed(
                RouteName.createTarget,
                pathParameters: {'subjectId': subjectId},
              ),
              icon: Icon(Icons.add, size: 18.r),
              label: Text(
                'Add target',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TargetCard extends ConsumerWidget {
  const _TargetCard({required this.target});
  final BehaviorTargetEntity target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final logsAsync = ref.watch(logsByTargetProvider(target.id));
    return GestureDetector(
      onTap: () => context.goNamed(
        RouteName.dailyLog,
        pathParameters: {'targetId': target.id},
      ),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: b.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: b.line),
          boxShadow: b.sh1,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    target.label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: b.ink,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      PillWidget(
                        label:
                            target.isActive ? 'Active' : 'Completed',
                        tone: target.isActive
                            ? PillTone.ok
                            : PillTone.neutral,
                        small: true,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'Goal: ${target.goalFrequency}',
                        style: TextStyle(
                          fontFamily: 'IBMPlexMono',
                          fontSize: 11.sp,
                          color: b.ink3,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            logsAsync.when(
              loading: () => SizedBox(width: 80.w, height: 32.h),
              error: (_, __) => const SizedBox(),
              data: (logs) => ProgressSparklineWidget(
                values: logs.map((l) => l.occurrenceCount).toList(),
                goal: target.goalFrequency,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.chevron_right, color: b.ink4, size: 20.r),
          ],
        ),
      ),
    );
  }
}
