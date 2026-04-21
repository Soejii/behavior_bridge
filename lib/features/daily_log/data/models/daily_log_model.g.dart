// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'daily_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$DailyLogModelImpl _$$DailyLogModelImplFromJson(Map<String, dynamic> json) =>
    _$DailyLogModelImpl(
      id: json['id'] as String,
      targetId: json['target_id'] as String,
      date: DateTime.parse(json['date'] as String),
      occurrenceCount: (json['occurrence_count'] as num).toInt(),
      reinforcementGiven: json['reinforcement_given'] as bool,
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$$DailyLogModelImplToJson(_$DailyLogModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'target_id': instance.targetId,
      'date': instance.date.toIso8601String(),
      'occurrence_count': instance.occurrenceCount,
      'reinforcement_given': instance.reinforcementGiven,
      'notes': instance.notes,
    };
