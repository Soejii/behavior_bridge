import 'package:flutter/material.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/analysis/domain/entities/analysis_result.dart';
import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';
import 'package:behavior_bridge/shared/widgets/pill_widget.dart';

class SuggestionCardWidget extends StatelessWidget {
  const SuggestionCardWidget({
    super.key,
    required this.result,
    this.onTap,
  });

  final AnalysisResult result;
  final VoidCallback? onTap;

  PillTone get tone => switch (result.status) {
        AnalysisStatus.baseline => PillTone.accent,
        AnalysisStatus.onTrack => PillTone.ok,
        AnalysisStatus.scheduleUpgrade => PillTone.ok,
        AnalysisStatus.plateauDetected => PillTone.warn,
        AnalysisStatus.extinctionRisk => PillTone.risk,
        AnalysisStatus.goalReached => PillTone.ok,
      };

  String get pillLabel => switch (result.status) {
        AnalysisStatus.baseline => 'Baseline',
        AnalysisStatus.onTrack => 'On track',
        AnalysisStatus.scheduleUpgrade => 'Ready to upgrade',
        AnalysisStatus.plateauDetected => 'Plateau detected',
        AnalysisStatus.extinctionRisk => 'Reward lapse',
        AnalysisStatus.goalReached => 'Goal reached',
      };

  @override
  Widget build(BuildContext context) {
    final b = context.brand;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: b.card,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: b.line),
          boxShadow: b.sh1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PillWidget(label: pillLabel, tone: tone, small: true),
            SizedBox(height: 10),
            Text(
              result.headline,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: b.ink,
              ),
            ),
            SizedBox(height: 6),
            Text(
              result.explanation,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13,
                color: b.ink2,
                height: 1.55,
              ),
            ),
            if (result.actionableAdvice != null) ...[
              SizedBox(height: 10),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: b.accentTint,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: 14, color: b.accentFg),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        result.actionableAdvice!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: b.accentFg,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
