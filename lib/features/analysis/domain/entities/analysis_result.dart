import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';

class AnalysisResult {
  const AnalysisResult({
    required this.status,
    required this.headline,
    required this.explanation,
    this.suggestedSchedule,
    this.actionableAdvice,
  });

  final AnalysisStatus status;
  final String headline;
  final String explanation;
  final ScheduleType? suggestedSchedule;
  final String? actionableAdvice;
}
