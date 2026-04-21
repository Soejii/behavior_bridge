import 'package:flutter/material.dart';
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
            icon: Icon(Icons.add, color: b.accent, size: 22),
            onPressed: () => context.pushNamed(RouteName.createSubject),
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
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: b.accentTint,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.person_outline, size: 32, color: b.accent),
            ),
            SizedBox(height: 16),
            Text(
              'Who are we supporting today?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w700,
                fontSize: 18,
                color: b.ink,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Add a child or student to start tracking their behavior.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: b.ink3,
                height: 1.5,
              ),
            ),
            SizedBox(height: 24),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: b.accent),
              onPressed: () => context.pushNamed(RouteName.createSubject),
              icon: Icon(Icons.add, size: 18),
              label: Text(
                'Add person',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
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
      padding: EdgeInsets.all(16),
      itemCount: subjects.length,
      separatorBuilder: (_, __) => SizedBox(height: 10),
      itemBuilder: (_, i) {
        final s = subjects[i];
        return GestureDetector(
          onTap: () => context.pushNamed(
            RouteName.subjectDetail,
            pathParameters: {'subjectId': s.id},
          ),
          child: Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: b.card,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: b.line),
              boxShadow: b.sh1,
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: b.accentTint,
                  child: Text(
                    s.name.substring(0, 1).toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: b.accent,
                    ),
                  ),
                ),
                SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        s.name,
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w600,
                          fontSize: 15,
                          color: b.ink,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        '${s.ageYears} yrs · ${s.relationship}',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: b.ink3,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: b.ink4, size: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
