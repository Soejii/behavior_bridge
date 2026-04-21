import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';
import 'package:behavior_bridge/features/analysis/presentation/providers/analysis_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
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
    final logsAsync = ref.watch(logsByTargetProvider(targetId));
    final b = context.brand;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(
        title: l.whatToDoNext,
        actions: [
          TextButton(
            onPressed: () {},
            child: Text(
              l.whyButton,
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
          final logCount = logsAsync.valueOrNull?.length ?? 0;
          final isCrfUpgrade = result.suggestedSchedule == ScheduleType.fr2;

          final headline = _headline(result.status, l, logCount, isCrfUpgrade);
          final explanation = _explanation(result.status, l, isCrfUpgrade);
          final advice = _advice(result.status, l, isCrfUpgrade);
          final whyText = _why(result.status, l);
          final actionText = _action(result.status, l);

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
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
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
                            headline,
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
                            explanation,
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
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (advice != null) ...[
                            Text(
                              l.tryThis,
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
                                    child: Icon(Icons.flag, size: 16, color: b.accentFg),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      advice,
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
                            l.whyThisWorks,
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
                              whyText,
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
                              if (result.status == AnalysisStatus.scheduleUpgrade ||
                                  result.status == AnalysisStatus.goalReached) {
                                final newSchedule =
                                    result.suggestedSchedule ?? ScheduleType.crf;
                                final current = ref
                                    .read(currentScheduleProvider(targetId))
                                    .valueOrNull;
                                await ref
                                    .read(reinforcementScheduleControllerProvider.notifier)
                                    .apply(
                                      targetId: targetId,
                                      type: newSchedule,
                                      ratio: newSchedule == ScheduleType.vr3 ? 3 : 2,
                                      intervalMinutes: 0,
                                      reinforcerDescription:
                                          current?.reinforcerDescription ??
                                              'Sticker on the chart',
                                    );
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        l.scheduleUpgradedTo(newSchedule.shortLabel),
                                      ),
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
                              actionText,
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
                              l.remindMeTomorrow,
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

  String _headline(
    AnalysisStatus status,
    AppLocalizations l,
    int logCount,
    bool isCrfUpgrade,
  ) {
    switch (status) {
      case AnalysisStatus.baseline:
        return l.baselineHeadline(logCount);
      case AnalysisStatus.goalReached:
        return l.goalReachedHeadline;
      case AnalysisStatus.extinctionRisk:
        return l.extinctionRiskHeadline;
      case AnalysisStatus.plateauDetected:
        return l.plateauHeadline;
      case AnalysisStatus.scheduleUpgrade:
        return isCrfUpgrade ? l.scheduleUpgradeCrfHeadline : l.scheduleUpgradeFrHeadline;
      case AnalysisStatus.onTrack:
        return l.onTrackHeadline;
    }
  }

  String _explanation(
    AnalysisStatus status,
    AppLocalizations l,
    bool isCrfUpgrade,
  ) {
    switch (status) {
      case AnalysisStatus.baseline:
        return l.baselineExplanation;
      case AnalysisStatus.goalReached:
        return l.goalReachedExplanation;
      case AnalysisStatus.extinctionRisk:
        return l.extinctionRiskExplanation;
      case AnalysisStatus.plateauDetected:
        return l.plateauExplanation;
      case AnalysisStatus.scheduleUpgrade:
        return isCrfUpgrade ? l.scheduleUpgradeCrfExplanation : l.scheduleUpgradeFrExplanation;
      case AnalysisStatus.onTrack:
        return l.onTrackExplanation;
    }
  }

  String? _advice(
    AnalysisStatus status,
    AppLocalizations l,
    bool isCrfUpgrade,
  ) {
    switch (status) {
      case AnalysisStatus.extinctionRisk:
        return l.extinctionRiskAdvice;
      case AnalysisStatus.plateauDetected:
        return l.plateauAdvice;
      case AnalysisStatus.scheduleUpgrade:
        return isCrfUpgrade ? l.scheduleUpgradeCrfAdvice : l.scheduleUpgradeFrAdvice;
      default:
        return null;
    }
  }

  String _why(AnalysisStatus status, AppLocalizations l) {
    switch (status) {
      case AnalysisStatus.scheduleUpgrade:
        return l.whyScheduleUpgrade;
      case AnalysisStatus.onTrack:
        return l.whyOnTrack;
      case AnalysisStatus.baseline:
        return l.whyBaseline;
      case AnalysisStatus.plateauDetected:
        return l.whyPlateau;
      case AnalysisStatus.extinctionRisk:
        return l.whyExtinctionRisk;
      case AnalysisStatus.goalReached:
        return l.whyGoalReached;
    }
  }

  String _action(AnalysisStatus status, AppLocalizations l) {
    switch (status) {
      case AnalysisStatus.scheduleUpgrade:
        return l.actionScheduleUpgrade;
      case AnalysisStatus.goalReached:
        return l.actionGoalReached;
      case AnalysisStatus.plateauDetected:
        return l.actionPlateau;
      case AnalysisStatus.extinctionRisk:
        return l.actionExtinctionRisk;
      default:
        return l.actionDefault;
    }
  }

  String _getTone(AnalysisStatus status) {
    switch (status) {
      case AnalysisStatus.baseline:
        return 'accent';
      case AnalysisStatus.onTrack:
      case AnalysisStatus.scheduleUpgrade:
      case AnalysisStatus.goalReached:
        return 'ok';
      case AnalysisStatus.plateauDetected:
        return 'warn';
      case AnalysisStatus.extinctionRisk:
        return 'risk';
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
      return status == AnalysisStatus.goalReached ? Icons.stars : Icons.auto_awesome;
    }
    if (tone == 'warn') return Icons.info_outline;
    if (tone == 'risk') return Icons.warning_amber_rounded;
    return Icons.auto_awesome;
  }
}
