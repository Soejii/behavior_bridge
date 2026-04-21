class DailyLogEntity {
  const DailyLogEntity({
    required this.id,
    required this.targetId,
    required this.date,
    required this.occurrenceCount,
    required this.reinforcementGiven,
    this.notes,
  });

  final String id;
  final String targetId;
  final DateTime date;
  final int occurrenceCount;
  final bool reinforcementGiven;
  final String? notes;

  DailyLogEntity copyWith({
    String? id,
    String? targetId,
    DateTime? date,
    int? occurrenceCount,
    bool? reinforcementGiven,
    String? notes,
  }) =>
      DailyLogEntity(
        id: id ?? this.id,
        targetId: targetId ?? this.targetId,
        date: date ?? this.date,
        occurrenceCount: occurrenceCount ?? this.occurrenceCount,
        reinforcementGiven: reinforcementGiven ?? this.reinforcementGiven,
        notes: notes ?? this.notes,
      );
}
