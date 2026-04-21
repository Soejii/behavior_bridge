import 'dart:math' as math;

import 'package:behavior_bridge/features/analysis/domain/entities/analysis_result.dart';
import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';

class BehaviorAnalysisEngine {
  const BehaviorAnalysisEngine();

  AnalysisResult run({
    required BehaviorTargetEntity target,
    required List<DailyLogEntity> logs,
    required ReinforcementScheduleEntity? currentSchedule,
    DateTime? now,
  }) {
    final effectiveNow = now ?? DateTime.now();
    final sorted = [...logs]..sort((a, b) => a.date.compareTo(b.date));
    final goal = target.goalFrequency;

    // 1. baseline — fewer than 3 days logged
    if (sorted.length <= 3) {
      return AnalysisResult(
        status: AnalysisStatus.baseline,
        headline: 'Keep observing — ${sorted.length} of 3 days logged',
        explanation:
            'A few baseline days help us understand where ${target.label.isEmpty ? "we" : "things stand"} now, before we suggest a plan.',
      );
    }

    // 2. goalReached — last 7 days all >= goal
    final last7 = _tail(sorted, 7);
    if (last7.length >= 7 && last7.every((l) => l.occurrenceCount >= goal)) {
      return const AnalysisResult(
        status: AnalysisStatus.goalReached,
        headline: 'Goal reached — 21 days of steady tidy-ups 🎉',
        explanation:
            'The habit is established. Move to surprise rewards to keep it going long-term.',
        suggestedSchedule: ScheduleType.vr3,
      );
    }

    // 3. extinctionRisk — last 3 days with reinforcementGiven == false
    final last3 = _tail(sorted, 3);
    if (last3.length >= 3 && last3.every((l) => !l.reinforcementGiven)) {
      return const AnalysisResult(
        status: AnalysisStatus.extinctionRisk,
        headline: "Rewards have slipped — let's get back on track",
        explanation:
            'Behaviors weaken quickly when rewards stop. Hand out a sticker today.',
        actionableAdvice:
            'Give a reward the next time the behavior occurs — even a small one helps.',
      );
    }

    // 4. plateauDetected — last 5 days within +/-1, avg < goal - 1, schedule >= 7d
    final last5 = _tail(sorted, 5);
    if (last5.length >= 5) {
      final counts = last5.map((l) => l.occurrenceCount).toList();
      final minV = counts.reduce(math.min);
      final maxV = counts.reduce(math.max);
      final avg = counts.reduce((a, b) => a + b) / counts.length;
      final scheduleAgeDays = currentSchedule == null
          ? 0
          : effectiveNow.difference(currentSchedule.appliedAt).inDays;
      if (maxV - minV <= 2 &&
          avg <= goal.toDouble() - 1.0 &&
          scheduleAgeDays >= 7) {
        return const AnalysisResult(
          status: AnalysisStatus.plateauDetected,
          headline: "Progress has flattened — let's adjust",
          explanation:
              'A fresh reward or a slightly easier goal can spark new motivation.',
          actionableAdvice:
              'Try a new reinforcer or lower the goal temporarily to rebuild momentum.',
        );
      }
    }

    // 5. scheduleUpgrade — CRF -> FR-2 after 5+ consecutive days at goal with stddev < 1.5;
    //    FR -> VR after 7 days at goal on FR
    if (currentSchedule != null) {
      final consecutiveAtGoal = _consecutiveAtGoalTail(sorted, goal);
      if (currentSchedule.type == ScheduleType.crf &&
          consecutiveAtGoal >= 5 &&
          _stddev(_tail(sorted, consecutiveAtGoal)
                  .map((l) => l.occurrenceCount.toDouble())
                  .toList()) <
              1.5) {
        return const AnalysisResult(
          status: AnalysisStatus.scheduleUpgrade,
          headline: 'Great streak! Time to mix up the rewards',
          explanation:
              'Rewarding every 2 times (instead of every time) makes the habit stronger and more lasting.',
          suggestedSchedule: ScheduleType.fr2,
          actionableAdvice:
              'Switch to FR-2 — reward every second occurrence.',
        );
      }
      final isFr = currentSchedule.type == ScheduleType.fr2 ||
          currentSchedule.type == ScheduleType.fr3;
      if (isFr && consecutiveAtGoal >= 7) {
        return const AnalysisResult(
          status: AnalysisStatus.scheduleUpgrade,
          headline: 'Great streak! Time to mix up the rewards',
          explanation:
              'Moving from fixed to variable rewards keeps the habit surprising and resilient.',
          suggestedSchedule: ScheduleType.vr3,
          actionableAdvice: 'Switch to VR-3 — reward on average every 3 times.',
        );
      }
    }

    // 6. onTrack — default fallback
    return const AnalysisResult(
      status: AnalysisStatus.onTrack,
      headline: 'Nice progress — on track toward goal',
      explanation:
          'Keep giving a sticker every single time — consistency is what makes a new habit stick.',
    );
  }

  static List<DailyLogEntity> _tail(List<DailyLogEntity> sorted, int n) {
    if (sorted.length <= n) return sorted;
    return sorted.sublist(sorted.length - n);
  }

  static int _consecutiveAtGoalTail(List<DailyLogEntity> sorted, int goal) {
    var count = 0;
    for (var i = sorted.length - 1; i >= 0; i--) {
      if (sorted[i].occurrenceCount >= goal) {
        count++;
      } else {
        break;
      }
    }
    return count;
  }

  static double _stddev(List<double> values) {
    if (values.isEmpty) return 0;
    final mean = values.reduce((a, b) => a + b) / values.length;
    final variance =
        values.map((v) => (v - mean) * (v - mean)).reduce((a, b) => a + b) /
            values.length;
    return math.sqrt(variance);
  }
}
