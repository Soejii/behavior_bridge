import 'package:behavior_bridge/features/subject/data/models/subject_model.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';

extension SubjectModelX on SubjectModel {
  SubjectEntity toEntity() => SubjectEntity(
        id: id,
        name: name,
        ageYears: ageYears,
        relationship: relationship,
        createdAt: createdAt,
      );
}

extension SubjectEntityX on SubjectEntity {
  SubjectModel toModel() => SubjectModel(
        id: id,
        name: name,
        ageYears: ageYears,
        relationship: relationship,
        createdAt: createdAt,
      );
}
