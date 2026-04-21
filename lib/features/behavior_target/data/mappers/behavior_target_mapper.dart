import 'package:behavior_bridge/features/behavior_target/data/models/behavior_target_model.dart';
import 'package:behavior_bridge/features/behavior_target/domain/entities/behavior_target_entity.dart';

extension BehaviorTargetModelX on BehaviorTargetModel {
  BehaviorTargetEntity toEntity() => BehaviorTargetEntity(
        id: id,
        subjectId: subjectId,
        label: label,
        description: description,
        baselineFrequency: baselineFrequency,
        goalFrequency: goalFrequency,
        isIncreasing: isIncreasing,
        startDate: startDate,
        isActive: isActive,
      );
}

extension BehaviorTargetEntityX on BehaviorTargetEntity {
  BehaviorTargetModel toModel() => BehaviorTargetModel(
        id: id,
        subjectId: subjectId,
        label: label,
        description: description,
        baselineFrequency: baselineFrequency,
        goalFrequency: goalFrequency,
        isIncreasing: isIncreasing,
        startDate: startDate,
        isActive: isActive,
      );
}
