import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';

enum PillTone { neutral, ok, warn, risk, accent }

class PillWidget extends StatelessWidget {
  const PillWidget({
    super.key,
    required this.label,
    this.tone = PillTone.neutral,
    this.small = false,
  });

  final String label;
  final PillTone tone;
  final bool small;

  @override
  Widget build(BuildContext context) {
    final b = context.brand;
    final palette = switch (tone) {
      PillTone.neutral => (bg: b.line2, fg: b.ink2, dot: b.ink3),
      PillTone.ok => (bg: b.okTint, fg: b.okDark, dot: b.ok),
      PillTone.warn => (bg: b.warnTint, fg: b.warnDark, dot: b.warn),
      PillTone.risk => (bg: b.riskTint, fg: b.risk, dot: b.risk),
      PillTone.accent => (bg: b.accentTint, fg: b.accentFg, dot: b.accent),
    };

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: small ? 8.w : 10.w,
        vertical: small ? 3.h : 5.h,
      ),
      decoration: BoxDecoration(
        color: palette.bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.r,
            height: 6.r,
            decoration: BoxDecoration(
              color: palette.dot,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: small ? 11.sp : 12.sp,
              fontWeight: FontWeight.w600,
              color: palette.fg,
              letterSpacing: 0.1,
            ),
          ),
        ],
      ),
    );
  }
}
