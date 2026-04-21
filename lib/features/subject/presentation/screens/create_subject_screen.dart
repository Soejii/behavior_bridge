import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:behavior_bridge/app/theme/brand_palette.dart';
import 'package:behavior_bridge/features/subject/presentation/providers/subject_providers.dart';
import 'package:behavior_bridge/shared/widgets/custom_app_bar_widget.dart';

const _relationships = ['Parent', 'Teacher', 'Therapist', 'Caregiver', 'Other'];

class CreateSubjectScreen extends HookConsumerWidget {
  const CreateSubjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final b = context.brand;
    final l = AppLocalizations.of(context)!;
    final nameCtrl = useTextEditingController();
    final ageCtrl = useTextEditingController();
    final relationship = useState(_relationships.first);
    final saving = useState(false);
    final formKey = useMemoized(GlobalKey<FormState>.new);

    Future<void> save() async {
      if (!formKey.currentState!.validate()) return;
      saving.value = true;
      try {
        await ref.read(subjectListControllerProvider.notifier).create(
              name: nameCtrl.text.trim(),
              ageYears: int.parse(ageCtrl.text.trim()),
              relationship: relationship.value,
            );
        if (context.mounted) context.pop();
      } finally {
        saving.value = false;
      }
    }

    return Scaffold(
      backgroundColor: b.bg,
      appBar: CustomAppBarWidget(title: l.addPerson),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              l.nameLabel,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: b.ink3,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: nameCtrl,
              decoration: inputDecoration(b, l.nameHint),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? l.nameRequired : null,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15,
                color: b.ink,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              l.ageLabel,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: b.ink3,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 6),
            TextFormField(
              controller: ageCtrl,
              keyboardType: TextInputType.number,
              decoration: inputDecoration(b, l.ageHint),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n < 1 || n > 99) return l.enterValidAge;
                return null;
              },
              style: const TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              l.roleLabel,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: b.ink3,
                letterSpacing: 0.6,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _relationships.map((r) {
                final selected = relationship.value == r;
                return GestureDetector(
                  onTap: () => relationship.value = r,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? b.accent : b.card,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: selected ? b.accent : b.line),
                    ),
                    child: Text(
                      r,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: selected ? b.card : b.ink2,
                      ),
                    ),
                  ),
                );
              }).toList(growable: false),
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
              child: saving.value
                  ? SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(
                        color: b.card,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      l.savePerson,
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

  InputDecoration inputDecoration(BrandPalette b, String hint) =>
      InputDecoration(
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
