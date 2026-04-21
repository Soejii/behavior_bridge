import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
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
    final l = AppLocalizations.of(context)!;
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
          context.pushNamed(
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
      appBar: CustomAppBarWidget(title: l.reinforcementSchedule),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l.howWillYouReward,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: b.ink,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            l.startWithCrf,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              color: b.ink3,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 18),
          ...ScheduleType.values.map(
            (t) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GestureDetector(
                onTap: () => selected.value = t,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: selected.value == t ? b.accentTint : b.card,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected.value == t ? b.accent : b.line,
                      width: selected.value == t ? 1.5 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: selected.value == t ? b.accent : b.line2,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            t.shortLabel,
                            style: TextStyle(
                              fontFamily: 'IBMPlexMono',
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: selected.value == t ? b.card : b.ink3,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          t.description,
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 13,
                            color: selected.value == t ? b.accentFg : b.ink2,
                          ),
                        ),
                      ),
                      if (selected.value == t)
                        Icon(Icons.check_circle, color: b.accent, size: 18),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l.whatsTheReward,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: b.ink3,
              letterSpacing: 0.6,
            ),
          ),
          const SizedBox(height: 6),
          TextField(
            controller: reinforcerCtrl,
            decoration: InputDecoration(
              hintText: l.reinforcerHint,
              hintStyle: TextStyle(fontFamily: 'Inter', color: b.ink4),
              filled: true,
              fillColor: b.card,
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: b.line),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: b.line),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: b.accent, width: 1.5),
              ),
            ),
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: b.ink,
            ),
          ),
          const SizedBox(height: 32),
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
              l.saveSchedule,
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
  }
}
