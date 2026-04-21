import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';
import 'package:behavior_bridge/features/analysis/presentation/providers/analysis_providers.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/providers/reinforcement_schedule_providers.dart';
import 'package:behavior_bridge/shared/screens/error_screen.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';

class SuggestionScreen extends ConsumerWidget {
  const SuggestionScreen({super.key, required this.targetId});
  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(analysisProvider(targetId));
    final b = context.brand;

    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(
        title: 'What to do next',
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              'Why?',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: b.accent,
              ),
            ),
          ),
        ],
      ),
      body: analysisAsync.when(
        loading: () => const LoadingScreen(),
        error: (e, _) => ErrorScreen(error: e),
        data: (result) {
          final tone = _getTone(result.status);
          final hero = _getHeroColor(b, tone);
          final heroTint = _getHeroTint(b, tone);
          final icon = _getHeroIcon(result.status, tone);

          return Column(
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    Container(
                      color: heroTint,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 22),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: hero,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(bottom: 12),
                            child: Icon(icon, size: 22, color: Colors.white),
                          ),
                          Text(
                            result.headline,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                              height: 1.25,
                              letterSpacing: -0.3,
                              color: b.ink,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            result.explanation,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 14,
                              color: b.ink2,
                              height: 1.55,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (result.actionableAdvice != null) ...[
                            Text(
                              'Try this',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                                color: b.ink3,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: b.card,
                                borderRadius: BorderRadius.circular(14),
                                border: Border.all(color: b.line),
                                boxShadow: b.sh1,
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: b.accentTint,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    alignment: Alignment.center,
                                    child: Icon(Icons.flag,
                                        size: 16, color: b.accentFg),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      result.actionableAdvice!,
                                      style: TextStyle(
                                        fontFamily: 'Inter',
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: b.ink,
                                        height: 1.45,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                          Text(
                            'Why this works',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: b.ink3,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: b.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: b.line),
                              boxShadow: b.sh1,
                            ),
                            child: Text(
                              _getWhyText(result.status),
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 13,
                                color: b.ink2,
                                height: 1.55,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: b.accent,
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () async {
                              if (result.status ==
                                      AnalysisStatus.scheduleUpgrade ||
                                  result.status == AnalysisStatus.goalReached) {
                                final newSchedule = result.suggestedSchedule ??
                                    ScheduleType.crf;
                                final current = ref
                                    .read(currentScheduleProvider(targetId))
                                    .valueOrNull;
                                await ref
                                    .read(
                                        reinforcementScheduleControllerProvider
                                            .notifier)
                                    .apply(
                                      targetId: targetId,
                                      type: newSchedule,
                                      ratio: newSchedule == ScheduleType.vr3
                                          ? 3
                                          : 2,
                                      intervalMinutes: 0,
                                      reinforcerDescription:
                                          current?.reinforcerDescription ??
                                              'Sticker on the chart',
                                    );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Schedule automatically upgraded to ${newSchedule.shortLabel}'),
                                      backgroundColor: b.ok,
                                      behavior: SnackBarBehavior.floating,
                                    ),
                                  );
                                  context.pop();
                                }
                              } else {
                                context.pop();
                              }
                            },
                            child: Text(
                              _getPrimaryActionText(result.status),
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: b.line, width: 1),
                              minimumSize: const Size.fromHeight(48),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              backgroundColor: b.card,
                            ),
                            onPressed: () => context.pop(),
                            child: Text(
                              'Remind me tomorrow',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                                color: b.ink,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getTone(AnalysisStatus status) {
    switch (status) {
      case AnalysisStatus.baseline:
        return 'accent';
      case AnalysisStatus.onTrack:
        return 'ok';
      case AnalysisStatus.scheduleUpgrade:
        return 'ok';
      case AnalysisStatus.plateauDetected:
        return 'warn';
      case AnalysisStatus.extinctionRisk:
        return 'risk';
      case AnalysisStatus.goalReached:
        return 'ok';
    }
  }

  Color _getHeroColor(BrandPalette b, String tone) {
    if (tone == 'ok') return b.ok;
    if (tone == 'warn') return b.warn;
    if (tone == 'risk') return b.risk;
    return b.accent;
  }

  Color _getHeroTint(BrandPalette b, String tone) {
    if (tone == 'ok') return b.okTint;
    if (tone == 'warn') return b.warnTint;
    if (tone == 'risk') return b.riskTint;
    return b.accentTint;
  }

  IconData _getHeroIcon(AnalysisStatus status, String tone) {
    if (tone == 'ok') {
      return status == AnalysisStatus.goalReached
          ? Icons.stars
          : Icons.auto_awesome;
    }
    if (tone == 'warn') return Icons.info_outline;
    if (tone == 'risk') return Icons.warning_amber_rounded;
    return Icons.auto_awesome;
  }

  String _getWhyText(AnalysisStatus status) {
    switch (status) {
      case AnalysisStatus.scheduleUpgrade:
        return 'Behaviors rewarded every single time learn fast — but they also fade fast when rewards stop. Rewarding every second time builds resilience: the brain learns "it might happen", which keeps the habit going even on days you forget.';
      case AnalysisStatus.onTrack:
        return 'During the early days of a new habit, consistency beats variety. Keep the rewards predictable until Maya has hit the goal 5–7 days in a row.';
      case AnalysisStatus.baseline:
        return 'A baseline tells us what "normal" looks like for Maya right now. Without it, we can\'t tell if progress is real — or if the reward is doing anything.';
      case AnalysisStatus.plateauDetected:
        return 'Plateaus usually mean the reward has lost its sparkle, or the ask has become too easy to matter. A small change — a new reward, a smaller ask — often kicks things back into gear.';
      case AnalysisStatus.extinctionRisk:
        return 'Behaviors depend on feedback. Three days without a reward tells Maya\'s brain "this isn\'t important" — and the habit will start to fade. Reinstate the sticker today to course-correct.';
      case AnalysisStatus.goalReached:
        return 'At 7+ days of consistent success, the behavior is officially a habit. Switching to surprise rewards (rather than stopping completely) keeps it strong for the long run.';
    }
  }

  String _getPrimaryActionText(AnalysisStatus status) {
    switch (status) {
      case AnalysisStatus.scheduleUpgrade:
        return 'Switch to "Every 2nd time"';
      case AnalysisStatus.goalReached:
        return 'Move to surprise rewards';
      case AnalysisStatus.plateauDetected:
        return 'Try a new reward';
      case AnalysisStatus.extinctionRisk:
        return 'Set a reminder';
      default:
        return 'Keep going';
    }
  }
}
