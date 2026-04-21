import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/analysis/presentation/providers/analysis_providers.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/features/subject/presentation/providers/subject_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/error_screen.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/pill_widget.dart';
import 'package:behavior_bridge/shared/widgets/progress_chart_widget.dart';

class SubjectDetailScreen extends ConsumerWidget {
  const SubjectDetailScreen({super.key, required this.subjectId});
  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(subjectListControllerProvider);
    final subjectAsync = subjectsAsync.whenData(
      (list) => list.firstWhere((s) => s.id == subjectId),
    );
    final targetsAsync = ref.watch(targetsBySubjectProvider(subjectId));
    final b = context.brand;

    return Scaffold(
      backgroundColor: b.bg,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Custom MBar
            Container(
              padding: const EdgeInsets.fromLTRB(18, 14, 18, 10),
              decoration: BoxDecoration(
                color: b.bg,
                border: Border(bottom: BorderSide(color: b.line)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Row(
                      children: [
                        Icon(Icons.chevron_left, size: 20, color: b.accent),
                        const SizedBox(width: 2),
                        Text(
                          'Back',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: b.accent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    subjectAsync.valueOrNull?.name ?? '',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: b.ink,
                    ),
                  ),
                  Icon(Icons.more_horiz, size: 20, color: b.accent),
                ],
              ),
            ),

            Expanded(
              child: subjectAsync.when(
                loading: () => const LoadingScreen(),
                error: (e, _) => ErrorScreen(error: e),
                data: (subject) {
                  final createdFormat = DateFormat('MMM d').format(subject.createdAt);

                  return ListView(
                    padding: const EdgeInsets.only(bottom: 20),
                    children: [
                      // Header Profile Block
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                        child: Row(
                          children: [
                            Container(
                              width: 56,
                              height: 56,
                              decoration: BoxDecoration(
                                color: b.accentTint,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.center,
                              child: Text(
                                subject.name.isNotEmpty ? subject.name.substring(0, 1).toUpperCase() : '?',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.w700,
                                  fontSize: 22,
                                  color: b.accent,
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    subject.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(
                                    '${subject.ageYears} years · ${subject.relationship} · since $createdFormat',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      color: b.ink3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Section Header
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'BEHAVIOR TARGETS',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: b.ink3,
                                letterSpacing: 0.6,
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.pushNamed(
                                RouteName.createTarget,
                                pathParameters: {'subjectId': subject.id},
                              ),
                              child: Row(
                                children: [
                                  Icon(Icons.add, size: 14, color: b.accent),
                                  const SizedBox(width: 3),
                                  Text(
                                    'New target',
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: b.accent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Targets List
                      targetsAsync.when(
                        loading: () => const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        ),
                        error: (e, _) => Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text('Error loading targets: $e'),
                        ),
                        data: (targets) {
                          if (targets.isEmpty) {
                            return _emptyTargets(context, subjectId);
                          }

                          final activeTargets = targets.where((t) => t.isActive).toList();
                          final completedTargets = targets.where((t) => !t.isActive).toList();

                          return Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 16),
                                child: Column(
                                  children: [
                                    if (activeTargets.isNotEmpty)
                                      _ActiveTargetCard(target: activeTargets.first),
                                    const SizedBox(height: 10),
                                    ...activeTargets.skip(1).map((t) => Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: _SecondaryTargetCard(target: t),
                                    )),
                                  ],
                                ),
                              ),

                              if (completedTargets.isNotEmpty) ...[
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'COMPLETED',
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: b.ink3,
                                        letterSpacing: 0.6,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Column(
                                    children: completedTargets.map((t) => Padding(
                                      padding: const EdgeInsets.only(bottom: 10),
                                      child: _CompletedTargetCard(target: t),
                                    )).toList(),
                                  ),
                                ),
                              ],
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _emptyTargets(BuildContext context, String subjectId) {
    final b = context.brand;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.track_changes, size: 48, color: b.accent),
            const SizedBox(height: 12),
            Text(
              'No targets yet',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: b.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add a behavior to track.',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: b.ink3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ActiveTargetCard extends ConsumerWidget {
  const _ActiveTargetCard({required this.target});
  final BehaviorTargetEntity target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final logsAsync = ref.watch(logsByTargetProvider(target.id));
    final analysisAsync = ref.watch(analysisProvider(target.id));

    final logs = logsAsync.valueOrNull ?? [];
    final values = logs.map((l) => l.occurrenceCount).toList();

    // We get the PillTone based on analysis
    PillTone tone = PillTone.neutral;
    String pillText = 'Analyzing';
    if (analysisAsync.hasValue && analysisAsync.value != null) {
       final status = analysisAsync.value!.status.name;
       if (status == 'baseline') {
         tone = PillTone.accent;
         pillText = 'Baseline';
       } else if (status == 'onTrack' || status == 'scheduleUpgrade' || status == 'goalReached') {
         tone = PillTone.ok;
         pillText = status == 'goalReached' ? 'Goal reached' : (status == 'scheduleUpgrade' ? 'Ready to upgrade' : 'On track');
       } else if (status == 'plateauDetected') {
         tone = PillTone.warn;
         pillText = 'Plateau detected';
       } else if (status == 'extinctionRisk') {
         tone = PillTone.risk;
         pillText = 'Reward lapse';
       }
    }

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: b.card,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: b.line),
        boxShadow: b.sh1,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: b.accentTint,
                  borderRadius: BorderRadius.circular(9),
                ),
                child: Icon(Icons.track_changes, size: 18, color: b.accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      target.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        height: 1.3,
                        color: b.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Goal: ${target.goalFrequency}x/day · ${target.isIncreasing ? "Increase" : "Decrease"}',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        color: b.ink3,
                      ),
                    ),
                  ],
                ),
              ),
              if (analysisAsync.hasValue)
                 PillWidget(label: pillText, tone: tone, small: true),
            ],
          ),
          const SizedBox(height: 14),
          if (values.isNotEmpty)
            SizedBox(
              height: 90,
              child: ProgressChartWidget(
                values: values,
                goal: target.goalFrequency,
                height: 90,
              ),
            ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: b.accent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => context.pushNamed(
                    RouteName.dailyLog,
                    pathParameters: {'targetId': target.id},
                  ),
                  icon: const Icon(Icons.check, size: 16),
                  label: const Text(
                    'Log today',
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: b.line),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => context.pushNamed(
                    RouteName.progress,
                    pathParameters: {'targetId': target.id},
                  ),
                  icon: Icon(Icons.trending_up, size: 16, color: b.ink),
                  label: Text(
                    'Progress',
                    style: TextStyle(fontFamily: 'Inter', fontWeight: FontWeight.w600, fontSize: 14, color: b.ink),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SecondaryTargetCard extends ConsumerWidget {
  const _SecondaryTargetCard({required this.target});
  final BehaviorTargetEntity target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final logsAsync = ref.watch(logsByTargetProvider(target.id));
    final logs = logsAsync.valueOrNull ?? [];

    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteName.progress,
        pathParameters: {'targetId': target.id},
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: b.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: b.line),
          boxShadow: b.sh1,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: b.bg,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(Icons.track_changes, size: 18, color: b.ink3),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    target.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: b.ink,
                    ),
                  ),
                  Text(
                    'Goal: ${target.goalFrequency}x/day · ${logs.length} days logged',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: b.ink3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: b.ink4, size: 18),
          ],
        ),
      ),
    );
  }
}

class _CompletedTargetCard extends ConsumerWidget {
  const _CompletedTargetCard({required this.target});
  final BehaviorTargetEntity target;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final logsAsync = ref.watch(logsByTargetProvider(target.id));
    final logs = logsAsync.valueOrNull ?? [];

    return GestureDetector(
      onTap: () => context.pushNamed(
        RouteName.progress,
        pathParameters: {'targetId': target.id},
      ),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: b.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: b.line),
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: b.okTint,
                borderRadius: BorderRadius.circular(9),
              ),
              child: Icon(Icons.star, size: 16, color: b.okDark),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    target.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: b.ink,
                    ),
                  ),
                  Text(
                    'Goal reached · ${logs.length} days logged',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 12,
                      color: b.ink3,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: b.ink4, size: 18),
          ],
        ),
      ),
    );
  }
}
