import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      appBar: const CustomAppBarWidget(title: 'Add person'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            Text(
              'NAME',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: b.ink3,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: nameCtrl,
              decoration: inputDecoration(b, 'e.g. Maya'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Name is required' : null,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'AGE (YEARS)',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: b.ink3,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 6.h),
            TextFormField(
              controller: ageCtrl,
              keyboardType: TextInputType.number,
              decoration: inputDecoration(b, 'e.g. 6'),
              validator: (v) {
                final n = int.tryParse(v ?? '');
                if (n == null || n < 1 || n > 99) return 'Enter a valid age';
                return null;
              },
              style: TextStyle(
                fontFamily: 'IBMPlexMono',
                fontSize: 15.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 18.h),
            Text(
              'YOUR ROLE',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 11.sp,
                fontWeight: FontWeight.w700,
                color: b.ink3,
                letterSpacing: 0.6,
              ),
            ),
            SizedBox(height: 6.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: _relationships.map((r) {
                final selected = relationship.value == r;
                return GestureDetector(
                  onTap: () => relationship.value = r,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: 14.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: selected ? b.accent : b.card,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(
                        color: selected ? b.accent : b.line,
                      ),
                    ),
                    child: Text(
                      r,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: selected ? b.card : b.ink2,
                      ),
                    ),
                  ),
                );
              }).toList(growable: false),
            ),
            SizedBox(height: 32.h),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: b.accent,
                minimumSize: Size.fromHeight(48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onPressed: saving.value ? null : save,
              child: saving.value
                  ? SizedBox(
                      width: 18.r,
                      height: 18.r,
                      child: CircularProgressIndicator(
                        color: b.card,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Save person',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 15.sp,
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
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: b.line),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: b.line),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.r),
          borderSide: BorderSide(color: b.accent, width: 1.5),
        ),
      );
}
