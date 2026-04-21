import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/presentation/providers/subject_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';

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
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 14),
              color: b.bg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 26,
                            height: 26,
                            decoration: BoxDecoration(
                              color: b.accent,
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: const Icon(Icons.auto_awesome, size: 15, color: Colors.white),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'BehaviorBridge',
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () => context.pushNamed(RouteName.createSubject),
                        child: Container(
                          width: 34,
                          height: 34,
                          decoration: BoxDecoration(
                            color: b.accentTint,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.add, size: 18, color: b.accent),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Who are we\nsupporting today?',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Pick a child to log or review.',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: b.ink3,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 8, bottom: 20),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                    child: Text(
                      'CHILDREN',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: b.ink3,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  if (subjects.isEmpty)
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        'No children added yet.',
                        style: TextStyle(fontFamily: 'Inter', color: b.ink3),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ...subjects.asMap().entries.map((entry) {
                      final i = entry.key;
                      final s = entry.value;
                      final avatarColor = i == 0 ? b.accentTint : (i == 1 ? b.okTint : b.warnTint);
                      final avatarFg = i == 0 ? b.accent : (i == 1 ? b.okDark : b.warnDark);
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                        child: GestureDetector(
                          onTap: () => context.pushNamed(
                            RouteName.subjectDetail,
                            pathParameters: {'subjectId': s.id},
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: b.card,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: b.line),
                              boxShadow: b.sh1,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 42,
                                  height: 42,
                                  decoration: BoxDecoration(
                                    color: avatarColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    s.name.substring(0, 1).toUpperCase(),
                                    style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      letterSpacing: -0.2,
                                      color: avatarFg,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
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
                                      const SizedBox(height: 2),
                                      Text(
                                        '\${s.ageYears} yrs · \${s.relationship}',
                                        style: TextStyle(
                                          fontFamily: 'Inter',
                                          fontSize: 12,
                                          color: b.ink3,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Icon(Icons.chevron_right, color: b.ink4, size: 18),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                    child: Text(
                      'TODAY AT A GLANCE',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: b.ink3,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: b.card,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: b.line),
                        boxShadow: b.sh1,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: b.okTint,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Icon(Icons.check, size: 18, color: b.okDark),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  '2 logs still to record',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  'Maya · Owen',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 12,
                                    color: b.ink3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: b.accentTint,
                              borderRadius: BorderRadius.circular(999),
                            ),
                            child: Text(
                              'Log now',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 11,
                                color: b.accent,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
