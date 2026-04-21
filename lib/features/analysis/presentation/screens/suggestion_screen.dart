import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/analysis/domain/entities/analysis_status.dart';
import 'package:behavior_bridge/features/analysis/presentation/providers/analysis_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/error_screen.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';
import 'package:behavior_bridge/shared/widgets/suggestion_card_widget.dart';

class SuggestionScreen extends ConsumerWidget {
  const SuggestionScreen({super.key, required this.targetId});
  final String targetId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysisAsync = ref.watch(analysisProvider(targetId));
    final b = context.brand;

    return Scaffold(
      backgroundColor: b.bg,
      appBar: const CustomAppBarWidget(title: 'Recommendation'),
      body: analysisAsync.when(
        loading: () => const LoadingScreen(),
        error: (e, _) => ErrorScreen(error: e),
        data: (result) => ListView(
          padding: EdgeInsets.all(16.w),
          children: [
            SuggestionCardWidget(result: result),
            SizedBox(height: 20.h),
            if (result.status == AnalysisStatus.scheduleUpgrade &&
                result.suggestedSchedule != null) ...[
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: b.accent,
                  minimumSize: Size.fromHeight(48.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                onPressed: () => context.goNamed(
                  RouteName.scheduleSetup,
                  pathParameters: {'targetId': targetId},
                ),
                child: Text(
                  'Apply new schedule',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    fontSize: 15.sp,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
            ],
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: b.line, width: 1.5),
                minimumSize: Size.fromHeight(44.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: () => context.goNamed(
                RouteName.dailyLog,
                pathParameters: {'targetId': targetId},
              ),
              child: Text(
                'Log today',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 15.sp,
                  color: b.ink2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
