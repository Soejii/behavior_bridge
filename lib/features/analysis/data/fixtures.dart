import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';

class FixtureSeries {
  const FixtureSeries({
    required this.key,
    required this.name,
    required this.status,
    required this.occurrences,
    required this.reinforced,
  });

  final String key;
  final String name;
  final AnalysisStatus status;
  final List<int> occurrences;
  final List<bool> reinforced;

  int get length => occurrences.length;
}

const List<FixtureSeries> kFixtureSeries = [
  FixtureSeries(
    key: 'baseline',
    name: 'Baseline (day 3)',
    status: AnalysisStatus.baseline,
    occurrences: [1, 2, 1],
    reinforced: [false, false, false],
  ),
  FixtureSeries(
    key: 'onTrack',
    name: 'On track',
    status: AnalysisStatus.onTrack,
    occurrences: [1, 2, 1, 2, 3, 3, 4, 3, 4, 3, 4, 4, 3, 4],
    reinforced: [
      true, true, true, true, true, true, true,
      true, true, true, true, true, true, true,
    ],
  ),
  FixtureSeries(
    key: 'scheduleUpgrade',
    name: 'Ready to upgrade',
    status: AnalysisStatus.scheduleUpgrade,
    occurrences: [1, 2, 1, 2, 3, 3, 4, 3, 4, 4, 4, 4, 4, 5, 4, 4],
    reinforced: [
      true, true, true, true, true, true, true, true,
      true, true, true, true, true, true, true, true,
    ],
  ),
  FixtureSeries(
    key: 'plateau',
    name: 'Plateau detected',
    status: AnalysisStatus.plateauDetected,
    occurrences: [1, 2, 1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3],
    reinforced: [
      true, true, true, true, true, true, true, true,
      true, true, true, true, true, true, true, true,
    ],
  ),
  FixtureSeries(
    key: 'extinctionRisk',
    name: 'Extinction risk',
    status: AnalysisStatus.extinctionRisk,
    occurrences: [1, 2, 1, 2, 3, 3, 4, 4, 4, 4, 3, 2, 2, 1, 1],
    reinforced: [
      true, true, true, true, true, true, true, true, true, true,
      false, false, false, false, false,
    ],
  ),
  FixtureSeries(
    key: 'goalReached',
    name: 'Goal reached',
    status: AnalysisStatus.goalReached,
    occurrences: [
      1, 2, 1, 2, 3, 3, 4, 3, 4, 4, 4,
      5, 4, 4, 5, 5, 4, 5, 4, 4, 5,
    ],
    reinforced: [
      true, true, true, true, true, true, true,
      true, true, true, true, true, true, true,
      true, true, true, true, true, true, true,
    ],
  ),
];

FixtureSeries fixtureByKey(String key) =>
    kFixtureSeries.firstWhere((f) => f.key == key);
