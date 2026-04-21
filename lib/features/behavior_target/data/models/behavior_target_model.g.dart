// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'behavior_target_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BehaviorTargetModelImpl _$$BehaviorTargetModelImplFromJson(
        Map<String, dynamic> json) =>
    _$BehaviorTargetModelImpl(
      id: json['id'] as String,
      subjectId: json['subject_id'] as String,
      label: json['label'] as String,
      description: json['description'] as String,
      baselineFrequency: (json['baseline_frequency'] as num).toInt(),
      goalFrequency: (json['goal_frequency'] as num).toInt(),
      isIncreasing: json['is_increasing'] as bool,
      startDate: DateTime.parse(json['start_date'] as String),
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$$BehaviorTargetModelImplToJson(
        _$BehaviorTargetModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'subject_id': instance.subjectId,
      'label': instance.label,
      'description': instance.description,
      'baseline_frequency': instance.baselineFrequency,
      'goal_frequency': instance.goalFrequency,
      'is_increasing': instance.isIncreasing,
      'start_date': instance.startDate.toIso8601String(),
      'is_active': instance.isActive,
    };
