enum ScheduleType {
  crf('CRF', 'Continuous — reward every time'),
  fr2('FR-2', 'Fixed ratio — every 2 occurrences'),
  fr3('FR-3', 'Fixed ratio — every 3 occurrences'),
  vr3('VR-3', 'Variable ratio — avg every 3'),
  vr5('VR-5', 'Variable ratio — avg every 5'),
  fi('FI', 'Fixed interval'),
  vi('VI', 'Variable interval');

  const ScheduleType(this.shortLabel, this.description);
  final String shortLabel;
  final String description;
}
