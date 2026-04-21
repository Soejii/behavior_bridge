import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/providers/behavior_target_providers.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';

class CreateTargetScreen extends HookConsumerWidget {
  const CreateTargetScreen({super.key, required this.subjectId});
  final String subjectId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final l = AppLocalizations.of(context)!;
    final labelCtrl = useTextEditingController();
    final descCtrl = useTextEditingController();
    final baseline = useState(1);
    final goal = useState(4);
    final isIncreasing = useState(true);
    final saving = useState(false);
    final formKey = useMemoized(GlobalKey<FormState>.new);

    Future<void> save() async {
      if (!formKey.currentState!.validate()) return;
      saving.value = true;
      try {
        final target = await ref
            .read(behaviorTargetControllerProvider.notifier)
            .create(
              subjectId: subjectId,
              label: labelCtrl.text.trim(),
              description: descCtrl.text.trim(),
              baselineFrequency: baseline.value,
              goalFrequency: goal.value,
              isIncreasing: isIncreasing.value,
            );
        if (context.mounted) {
          context.pushNamed(
            RouteName.scheduleSetup,
            pathParameters: {'targetId': target.id},
          );
        }
      } finally {
        saving.value = false;
      }
    }

    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(title: l.newTargetTitle),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _fieldLabel(b, l.behaviorLabelField),
            const SizedBox(height: 6),
            TextFormField(
              controller: labelCtrl,
              decoration: _inputDec(b, l.behaviorLabelHint),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l.fieldRequired : null,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: b.ink,
              ),
            ),
            const SizedBox(height: 16),
            _fieldLabel(b, l.descriptionField),
            const SizedBox(height: 6),
            TextFormField(
              controller: descCtrl,
              minLines: 2,
              maxLines: 4,
              decoration: _inputDec(b, l.descriptionHint),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14,
                color: b.ink,
              ),
            ),
            const SizedBox(height: 16),
            _fieldLabel(b, l.directionLabel),
            const SizedBox(height: 8),
            Row(
              children: [
                _RadioChip(
                  label: l.increasing,
                  selected: isIncreasing.value,
                  onTap: () => isIncreasing.value = true,
                  b: b,
                ),
                const SizedBox(width: 10),
                _RadioChip(
                  label: l.decreasing,
                  selected: !isIncreasing.value,
                  onTap: () => isIncreasing.value = false,
                  b: b,
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel(b, l.baselinePerDay),
                      const SizedBox(height: 6),
                      _NumberStepper(
                        value: baseline.value,
                        min: 0,
                        max: 20,
                        onChanged: (v) => baseline.value = v,
                        b: b,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _fieldLabel(b, l.goalPerDayField),
                      const SizedBox(height: 6),
                      _NumberStepper(
                        value: goal.value,
                        min: 1,
                        max: 30,
                        onChanged: (v) => goal.value = v,
                        b: b,
                      ),
                    ],
                  ),
                ),
              ],
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
                l.nextSetSchedule,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _fieldLabel(BrandPalette b, String text) => Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: b.ink3,
          letterSpacing: 0.6,
        ),
      );

  InputDecoration _inputDec(BrandPalette b, String hint) => InputDecoration(
        hintText: hint,
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
      );
}

class _RadioChip extends StatelessWidget {
  const _RadioChip({
    required this.label,
    required this.selected,
    required this.onTap,
    required this.b,
  });
  final String label;
  final bool selected;
  final VoidCallback onTap;
  final BrandPalette b;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
          decoration: BoxDecoration(
            color: selected ? b.accent : b.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: selected ? b.accent : b.line),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected ? b.card : b.ink2,
            ),
          ),
        ),
      );
}

class _NumberStepper extends StatelessWidget {
  const _NumberStepper({
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    required this.b,
  });
  final int value;
  final int min;
  final int max;
  final ValueChanged<int> onChanged;
  final BrandPalette b;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          IconButton(
            onPressed: value > min ? () => onChanged(value - 1) : null,
            icon: const Icon(Icons.remove, size: 18),
            color: b.ink2,
            disabledColor: b.ink4,
          ),
          Text(
            '$value',
            style: TextStyle(
              fontFamily: 'IBMPlexMono',
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: b.ink,
            ),
          ),
          IconButton(
            onPressed: value < max ? () => onChanged(value + 1) : null,
            icon: const Icon(Icons.add, size: 18),
            color: b.ink2,
            disabledColor: b.ink4,
          ),
        ],
      );
}
