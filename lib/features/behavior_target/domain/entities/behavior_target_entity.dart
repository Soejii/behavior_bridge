class BehaviorTargetEntity {
  const BehaviorTargetEntity({
    required this.id,
    required this.subjectId,
    required this.label,
    required this.description,
    required this.baselineFrequency,
    required this.goalFrequency,
    required this.isIncreasing,
    required this.startDate,
    required this.isActive,
  });

  final String id;
  final String subjectId;
  final String label;
  final String description;
  final int baselineFrequency;
  final int goalFrequency;
  final bool isIncreasing;
  final DateTime startDate;
  final bool isActive;

  BehaviorTargetEntity copyWith({
    String? id,
    String? subjectId,
    String? label,
    String? description,
    int? baselineFrequency,
    int? goalFrequency,
    bool? isIncreasing,
    DateTime? startDate,
    bool? isActive,
  }) =>
      BehaviorTargetEntity(
        id: id ?? this.id,
        subjectId: subjectId ?? this.subjectId,
        label: label ?? this.label,
        description: description ?? this.description,
        baselineFrequency: baselineFrequency ?? this.baselineFrequency,
        goalFrequency: goalFrequency ?? this.goalFrequency,
        isIncreasing: isIncreasing ?? this.isIncreasing,
        startDate: startDate ?? this.startDate,
        isActive: isActive ?? this.isActive,
      );
}
