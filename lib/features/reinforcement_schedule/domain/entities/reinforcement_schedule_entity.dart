import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';

class ReinforcementScheduleEntity {
  const ReinforcementScheduleEntity({
    required this.id,
    required this.targetId,
    required this.type,
    required this.ratio,
    required this.intervalMinutes,
    required this.reinforcerDescription,
    required this.appliedAt,
  });

  final String id;
  final String targetId;
  final ScheduleType type;
  final int ratio;
  final int intervalMinutes;
  final String reinforcerDescription;
  final DateTime appliedAt;

  ReinforcementScheduleEntity copyWith({
    String? id,
    String? targetId,
    ScheduleType? type,
    int? ratio,
    int? intervalMinutes,
    String? reinforcerDescription,
    DateTime? appliedAt,
  }) =>
      ReinforcementScheduleEntity(
        id: id ?? this.id,
        targetId: targetId ?? this.targetId,
        type: type ?? this.type,
        ratio: ratio ?? this.ratio,
        intervalMinutes: intervalMinutes ?? this.intervalMinutes,
        reinforcerDescription:
            reinforcerDescription ?? this.reinforcerDescription,
        appliedAt: appliedAt ?? this.appliedAt,
      );
}
