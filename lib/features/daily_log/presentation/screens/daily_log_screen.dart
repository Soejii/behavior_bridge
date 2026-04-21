import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final l = AppLocalizations.of(context)!;

    return targetAsync.when(
      loading: () => const LoadingScreen(),
      error: (e, _) => Scaffold(body: Center(child: Text('$e'))),
      data: (target) {
        if (target == null) {
          return Scaffold(
            body: Center(
              child: Text(
                l.targetNotFound,
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
                  context.pushNamed(
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
                padding: const EdgeInsets.all(20),
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: b.card,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: b.line),
                      boxShadow: b.sh1,
                    ),
                    child: Column(
                      children: [
                        Text(
                          l.howManyTimesToday,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: b.ink2,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: count.value > 0 ? () => count.value-- : null,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: b.line2,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Icon(Icons.remove,
                                    color: count.value > 0 ? b.ink2 : b.ink4,
                                    size: 20),
                              ),
                            ),
                            const SizedBox(width: 32),
                            Text(
                              '${count.value}',
                              style: TextStyle(
                                fontFamily: 'IBMPlexMono',
                                fontSize: 48,
                                fontWeight: FontWeight.w700,
                                color: count.value >= target.goalFrequency
                                    ? b.ok
                                    : b.ink,
                              ),
                            ),
                            const SizedBox(width: 32),
                            GestureDetector(
                              onTap: () => count.value++,
                              child: Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  color: b.accent,
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Icon(Icons.add, color: b.card, size: 20),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          l.goalPerDay(target.goalFrequency),
                          style: TextStyle(
                            fontFamily: 'IBMPlexMono',
                            fontSize: 12,
                            color: b.ink3,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: b.card,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: b.line),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                l.rewardGivenToday,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: b.ink,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                l.consistencyBuildsHabit,
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
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
                  const SizedBox(height: 28),
                  FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: b.accent,
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: saving.value ? null : save,
                    child: Text(
                      l.saveTodaysLog,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
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
