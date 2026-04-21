import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_log_model.freezed.dart';
part 'daily_log_model.g.dart';

@freezed
class DailyLogModel with _$DailyLogModel {
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory DailyLogModel({
    required String id,
    required String targetId,
    required DateTime date,
    required int occurrenceCount,
    required bool reinforcementGiven,
    String? notes,
  }) = _DailyLogModel;

  factory DailyLogModel.fromJson(Map<String, dynamic> json) =>
      _$DailyLogModelFromJson(json);
}
