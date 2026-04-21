import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/subject/domain/entities/subject_entity.dart';
import 'package:behavior_bridge/features/subject/presentation/providers/subject_providers.dart';
import 'package:behavior_bridge/shared/core/constant/locale_provider.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/loading_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final subjectsAsync = ref.watch(subjectListControllerProvider);
    return subjectsAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => const _HomeBody(subjects: []),
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
    final l = AppLocalizations.of(context)!;
    final locale = ref.watch(localeNotifierProvider);

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
                          Text(
                            l.appName,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _LangToggle(current: locale.languageCode),
                          const SizedBox(width: 8),
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
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    l.homeTitle,
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l.homeSubtitle,
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
                      l.sectionChildren,
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
                        l.noChildren,
                        style: TextStyle(fontFamily: 'Inter', color: b.ink3),
                        textAlign: TextAlign.center,
                      ),
                    )
                  else
                    ...subjects.asMap().entries.map((entry) {
                      final i = entry.key;
                      final s = entry.value;
                      final colorIndex = i % 3;
                      final avatarColor = colorIndex == 0 ? b.accentTint : (colorIndex == 1 ? b.okTint : b.warnTint);
                      final avatarFg = colorIndex == 0 ? b.accent : (colorIndex == 1 ? b.okDark : b.warnDark);

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
                                    s.name.isNotEmpty ? s.name.substring(0, 1).toUpperCase() : '?',
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
                                        l.subjectMeta(s.ageYears, s.relationship),
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
                      l.sectionToday,
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
                              l.logNow,
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

class _LangToggle extends ConsumerWidget {
  const _LangToggle({required this.current});
  final String current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    return Container(
      decoration: BoxDecoration(
        color: b.line2,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _Chip(label: 'EN', active: current == 'en', onTap: () => ref.read(localeNotifierProvider.notifier).setLocale(const Locale('en')), b: b),
          _Chip(label: 'ID', active: current == 'id', onTap: () => ref.read(localeNotifierProvider.notifier).setLocale(const Locale('id')), b: b),
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.active, required this.onTap, required this.b});
  final String label;
  final bool active;
  final VoidCallback onTap;
  final BrandPalette b;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            color: active ? b.accent : Colors.transparent,
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: active ? Colors.white : b.ink3,
            ),
          ),
        ),
      );
}
