// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reinforcement_schedule_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReinforcementScheduleModelImpl _$$ReinforcementScheduleModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ReinforcementScheduleModelImpl(
      id: json['id'] as String,
      targetId: json['target_id'] as String,
      type: $enumDecode(_$ScheduleTypeEnumMap, json['type']),
      ratio: (json['ratio'] as num).toInt(),
      intervalMinutes: (json['interval_minutes'] as num).toInt(),
      reinforcerDescription: json['reinforcer_description'] as String,
      appliedAt: DateTime.parse(json['applied_at'] as String),
    );

Map<String, dynamic> _$$ReinforcementScheduleModelImplToJson(
        _$ReinforcementScheduleModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'target_id': instance.targetId,
      'type': _$ScheduleTypeEnumMap[instance.type]!,
      'ratio': instance.ratio,
      'interval_minutes': instance.intervalMinutes,
      'reinforcer_description': instance.reinforcerDescription,
      'applied_at': instance.appliedAt.toIso8601String(),
    };

const _$ScheduleTypeEnumMap = {
  ScheduleType.crf: 'crf',
  ScheduleType.fr2: 'fr2',
  ScheduleType.fr3: 'fr3',
  ScheduleType.vr3: 'vr3',
  ScheduleType.vr5: 'vr5',
  ScheduleType.fi: 'fi',
  ScheduleType.vi: 'vi',
};
