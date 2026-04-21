import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: b.card,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: b.line),
          boxShadow: b.sh1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PillWidget(label: pillLabel, tone: tone, small: true),
            SizedBox(height: 10.h),
            Text(
              result.headline,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              result.explanation,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 13.sp,
                color: b.ink2,
                height: 1.55,
              ),
            ),
            if (result.actionableAdvice != null) ...[
              SizedBox(height: 10.h),
              Container(
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: b.accentTint,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: 14.r, color: b.accentFg),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        result.actionableAdvice!,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
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
