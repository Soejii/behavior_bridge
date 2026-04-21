import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/domain/entities/schedule_type.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/providers/reinforcement_schedule_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';

class ScheduleSetupScreen extends HookConsumerWidget {
  const ScheduleSetupScreen({super.key, required this.targetId});
  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final selected = useState(ScheduleType.crf);
    final reinforcerCtrl = useTextEditingController(text: 'Sticker on the chart');
    final saving = useState(false);

    Future<void> save() async {
      saving.value = true;
      try {
        await ref.read(reinforcementScheduleControllerProvider.notifier).apply(
              targetId: targetId,
              type: selected.value,
              ratio: selected.value == ScheduleType.crf ? 1 : 2,
              intervalMinutes: 0,
              reinforcerDescription: reinforcerCtrl.text.trim(),
            );
        if (context.mounted) {
          context.goNamed(
            RouteName.dailyLog,
            pathParameters: {'targetId': targetId},
          );
        }
      } finally {
        saving.value = false;
      }
    }

    return Scaffold(
      backgroundColor: b.bg,
      appBar: const CustomAppBarWidget(title: 'Reinforcement schedule'),
      body: ListView(
        padding: EdgeInsets.all(20.w),
        children: [
          Text(
            'How will you reward the behavior?',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16.sp,
              color: b.ink,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            'Start with CRF — reward every single time.',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.sp,
              color: b.ink3,
              height: 1.5,
            ),
          ),
          SizedBox(height: 18.h),
          ...ScheduleType.values.map(
            (t) => Padding(
              padding: EdgeInsets.only(bottom: 10.h),
              child: GestureDetector(
                onTap: () => selected.value = t,
                child: Container(
                  padding: EdgeInsets.all(14.w),
                  decoration: BoxDecoration(
                    color: selected.value == t ? b.accentTint : b.card,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color:
                          selected.value == t ? b.accent : b.line,
                      width: selected.value == t ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                          color: selected.value == t
                              ? b.accent
                              : b.line2,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Center(
                          child: Text(
                            t.shortLabel,
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w700,
                              color: selected.value == t
                                  ? b.card
                                  : b.ink3,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          t.description,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13.sp,
                            color: selected.value == t
                                ? b.accentFg
                                : b.ink2,
                          ),
                        ),
                      ),
                      if (selected.value == t)
                        Icon(Icons.check_circle,
                            color: b.accent, size: 18.r),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'WHAT\'S THE REWARD?',
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11.sp,
              fontWeight: FontWeight.w700,
              color: b.ink3,
              letterSpacing: 0.6,
            ),
          ),
          SizedBox(height: 6.h),
          TextField(
            controller: reinforcerCtrl,
            decoration: InputDecoration(
              hintText: 'e.g. Sticker on the chart',
              hintStyle: TextStyle(fontFamily: 'Inter', color: b.ink4),
              filled: true,
              fillColor: b.card,
              contentPadding: EdgeInsets.symmetric(
                  horizontal: 14.w, vertical: 12.h),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: b.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: b.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
                borderSide: BorderSide(color: b.accent, width: 1.5),
              ),
            ),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14.sp,
              color: b.ink,
            ),
          ),
          SizedBox(height: 32.h),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: b.accent,
              minimumSize: Size.fromHeight(48.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            onPressed: saving.value ? null : save,
            child: Text(
              'Save schedule — start logging',
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
