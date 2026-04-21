import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/features/daily_log/presentation/providers/daily_log_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';

class DailyLogScreen extends HookConsumerWidget {
  const DailyLogScreen({super.key, required this.targetId});
  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final targetAsync = ref.watch(targetByIdProvider(targetId));
    final todayLogAsync = ref.watch(logForTargetTodayProvider(targetId));
    final b = context.brand;

    return targetAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (target) {
        if (target == null) {
          return Scaffold(
            body: Center(
              child: Text(
                'Target not found',
                style: TextStyle(fontFamily: 'Inter', color: b.ink3),
              ),
            ),
          );
        }
        return todayLogAsync.when(
          loading: () => const LoadingScreen(),
          error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
          data: (existing) {
            final count = useState(existing?.occurrenceCount ?? 0);
            final reinforced = useState(existing?.reinforcementGiven ?? true);
            final saving = useState(false);

            Future<void> save() async {
              saving.value = true;
              try {
                await ref.read(dailyLogControllerProvider.notifier).upsertToday(
                      targetId: targetId,
                      occurrenceCount: count.value,
                      reinforcementGiven: reinforced.value,
                    );
                if (context.mounted) {
                  context.goNamed(
                    RouteName.progress,
                    pathParameters: {'targetId': targetId},
                  );
                }
              } finally {
                saving.value = false;
              }
            }

            return Scaffold(
              backgroundColor: b.bg,
              appBar: CustomAppBarWidget(
                title: target.label,
                subtitle: DateFormat('EEEE, MMM d').format(DateTime.now()),
              ),
              body: ListView(
                padding: EdgeInsets.all(20.w),
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    decoration: BoxDecoration(
                      color: b.card,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(color: b.line),
                      boxShadow: b.sh1,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'How many times today?',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: b.ink2,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: count.value > 0
                                  ? () => count.value--
                                  : null,
                              child: Container(
                                width: 48.r,
                                height: 48.r,
                                decoration: BoxDecoration(
                                  color: b.line2,
                                  borderRadius:
                                      BorderRadius.circular(999),
                                ),
                                child: Icon(Icons.remove,
                                    color: count.value > 0
                                        ? b.ink2
                                        : b.ink4,
                                    size: 20.r),
                              ),
                            ),
                            SizedBox(width: 32.w),
                            Text(
                              '${count.value}',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 48.sp,
                                fontWeight: FontWeight.w700,
                                color: count.value >= target.goalFrequency
                                    ? b.ok
                                    : b.ink,
                              ),
                            ),
                            SizedBox(width: 32.w),
                            GestureDetector(
                              onTap: () => count.value++,
                              child: Container(
                                width: 48.r,
                                height: 48.r,
                                decoration: BoxDecoration(
                                  color: b.accent,
                                  borderRadius:
                                      BorderRadius.circular(999),
                                ),
                                child: Icon(Icons.add,
                                    color: b.card, size: 20.r),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'goal: ${target.goalFrequency} / day',
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 12.sp,
                            color: b.ink3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: b.card,
                      borderRadius: BorderRadius.circular(14.r),
                      border: Border.all(color: b.line),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Reward given today?',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: b.ink,
                                ),
                              ),
                              SizedBox(height: 2.h),
                              Text(
                                'Consistency builds the habit.',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12.sp,
                                  color: b.ink3,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: reinforced.value,
                          onChanged: (v) => reinforced.value = v,
                          activeColor: b.ok,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 28.h),
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
                      'Save today\'s log',
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
          },
        );
      },
    );
  }
}
