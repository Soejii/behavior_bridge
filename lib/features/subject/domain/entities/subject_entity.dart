class SubjectEntity {
  const SubjectEntity({
    required this.id,
    required this.name,
    required this.ageYears,
    required this.relationship,
    required this.createdAt,
  });

  final String id;
  final String name;
  final int ageYears;
  final String relationship;
  final DateTime createdAt;

  SubjectEntity copyWith({
    String? id,
    String? name,
    int? ageYears,
    String? relationship,
    DateTime? createdAt,
  }) =>
      SubjectEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        ageYears: ageYears ?? this.ageYears,
        relationship: relationship ?? this.relationship,
        createdAt: createdAt ?? this.createdAt,
      );
}
