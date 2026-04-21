import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';

class StatCardWidget extends StatelessWidget {
  const StatCardWidget({
    super.key,
    required this.label,
    required this.value,
    this.hint,
    this.emphasize = false,
  });

  final String label;
  final String value;
  final String? hint;
  final bool emphasize;

  @override
  Widget build(BuildContext context) {
    final b = context.brand;
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: b.card,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: b.line),
        boxShadow: b.sh1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label.toUpperCase(),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: b.ink3,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'IBMPlexMono',
              fontSize: emphasize ? 22.sp : 18.sp,
              fontWeight: FontWeight.w700,
              color: emphasize ? b.accent : b.ink,
            ),
          ),
          if (hint != null) ...[
            SizedBox(height: 4.h),
            Text(
              hint!,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.sp,
                color: b.ink3,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
