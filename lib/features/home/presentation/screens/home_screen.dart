import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/presentation/providers/subject_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(subjectListControllerProvider);
    return subjectsAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => subjectsAsync.when(
        loading: () => const LoadingScreen(),
        error: (_, __) => const _HomeBody(subjects: []),
        data: (s) => _HomeBody(subjects: s),
      ),
      data: (subjects) => _HomeBody(subjects: subjects),
    );
  }
}

class _HomeBody extends ConsumerWidget {
  const _HomeBody({required this.subjects});
  final List<SubjectEntity> subjects;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(
        title: 'BehaviorBridge',
        showBack: false,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: b.accent, size: 22.r),
            onPressed: () => context.goNamed(RouteName.createSubject),
            tooltip: 'Add person',
          ),
        ],
      ),
      body: subjects.isEmpty ? emptyState(context) : subjectList(context),
    );
  }

  Widget emptyState(BuildContext context) {
    final b = context.brand;
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64.r,
              height: 64.r,
              decoration: BoxDecoration(
                color: b.accentTint,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Icon(Icons.person_outline, size: 32.r, color: b.accent),
            ),
            SizedBox(height: 16.h),
            Text(
              'Who are we supporting today?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Add a child or student to start tracking their behavior.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                color: b.ink3,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24.h),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: b.accent),
              onPressed: () => context.goNamed(RouteName.createSubject),
              icon: Icon(Icons.add, size: 18.r),
              label: Text(
                'Add person',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget subjectList(BuildContext context) {
    final b = context.brand;
    return ListView.separated(
      padding: EdgeInsets.all(16.w),
      itemCount: subjects.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (_, i) {
        final s = subjects[i];
        return GestureDetector(
          onTap: () => context.goNamed(
            RouteName.subjectDetail,
            pathParameters: {'subjectId': s.id},
          ),
          child: Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: b.card,
              borderRadius: BorderRadius.circular(14.r),
              border: Border.all(color: b.line),
              boxShadow: b.sh1,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22.r,
                  backgroundColor: b.accentTint,
                  child: Text(
                    s.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16.sp,
                      color: b.accent,
                    ),
                  ),
                ),
                SizedBox(width: 14.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.name,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15.sp,
                          color: b.ink,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        '${s.ageYears} yrs · ${s.relationship}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12.sp,
                          color: b.ink3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: b.ink4, size: 20.r),
              ],
            ),
          ),
        );
      },
    );
  }
}
