import 'package:uuid/uuid.dart';

import 'package:behavior_bridge/features/analysis/data/fixtures.dart';
import 'package:behavior_bridge/features/behavior_target/domain/behavior_target_repository.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';
import 'package:behavior_bridge/features/daily_log/domain/daily_log_repository.dart';
import 'package:behavior_bridge/features/daily_log/domain/entities/daily_log_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/reinforcement_schedule_entity.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/reinforcement_schedule_repository.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/domain/subject_repository.dart';

class SeedUsecase {
  const SeedUsecase({
    required SubjectRepository subjects,
    required BehaviorTargetRepository targets,
    required ReinforcementScheduleRepository schedules,
    required DailyLogRepository logs,
  })  : _subjects = subjects,
        _targets = targets,
        _schedules = schedules,
        _logs = logs;

  final SubjectRepository _subjects;
  final BehaviorTargetRepository _targets;
  final ReinforcementScheduleRepository _schedules;
  final DailyLogRepository _logs;

  static const Uuid _uuid = Uuid();

  Future<SeedResult> run({
    DateTime? today,
  }) async {
    final now = today ?? DateTime.now();

    final subject = SubjectEntity(
      id: _uuid.v4(),
      name: 'Maya',
      ageYears: 6,
      relationship: 'Parent',
      createdAt: now.subtract(const Duration(days: 30)),
    );
    (await _subjects.upsert(subject)).fold((f) => throw f, (_) => null);

    final labels = {
      'baseline': 'Washing hands before dinner',
      'onTrack': 'Tidying up toys after play',
      'scheduleUpgrade': 'Completing homework without prompts',
      'plateau': 'Brushing teeth for 2 minutes',
      'extinctionRisk': 'Reading 15 minutes before bed',
      'goalReached': 'Making bed in the morning',
    };

    BehaviorTargetEntity? firstTarget;
    ReinforcementScheduleEntity? firstSchedule;

    for (final fixture in kFixtureSeries) {
      final target = BehaviorTargetEntity(
        id: _uuid.v4(),
        subjectId: subject.id,
        label: labels[fixture.key] ?? 'Behavior target',
        description: 'Demo target showcasing the \${fixture.name} state.',
        baselineFrequency: 1,
        goalFrequency: 4,
        isIncreasing: true,
        startDate: now.subtract(Duration(days: fixture.length)),
        isActive: fixture.key != 'goalReached',
      );
      (await _targets.upsert(target)).fold((f) => throw f, (_) => null);

      firstTarget ??= target;

      final schedule = ReinforcementScheduleEntity(
        id: _uuid.v4(),
        targetId: target.id,
        type: (fixture.key == 'scheduleUpgrade' || fixture.key == 'goalReached')
            ? ScheduleType.fr2
            : ScheduleType.crf,
        ratio:
            (fixture.key == 'scheduleUpgrade' || fixture.key == 'goalReached')
                ? 2
                : 1,
        intervalMinutes: 0,
        reinforcerDescription: 'Sticker on the chart',
        appliedAt: now.subtract(Duration(days: fixture.length)),
      );
      (await _schedules.upsert(schedule)).fold((f) => throw f, (_) => null);

      firstSchedule ??= schedule;

      for (var i = 0; i < fixture.length; i++) {
        final day = DateTime(now.year, now.month, now.day)
            .subtract(Duration(days: fixture.length - 1 - i));
        final log = DailyLogEntity(
          id: _uuid.v4(),
          targetId: target.id,
          date: day,
          occurrenceCount: fixture.occurrences[i],
          reinforcementGiven: fixture.reinforced[i],
        );
        (await _logs.upsert(log)).fold((f) => throw f, (_) => null);
      }
    }

    return SeedResult(
      subject: subject,
      target: firstTarget!,
      schedule: firstSchedule!,
    );
  }
}

class SeedResult {
  const SeedResult({
    required this.subject,
    required this.target,
    required this.schedule,
  });

  final SubjectEntity subject;
  final BehaviorTargetEntity target;
  final ReinforcementScheduleEntity schedule;
}
