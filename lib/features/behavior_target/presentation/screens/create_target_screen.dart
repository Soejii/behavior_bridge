import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          context.goNamed(
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
      appBar: const CustomAppBarWidget(title: 'New target'),
      body: Form(
        key: formKey,
        child: ListView(
          padding: EdgeInsets.all(20.w),
          children: [
            fieldLabel(b, 'BEHAVIOR LABEL'),
            SizedBox(height: 6.h),
            TextFormField(
              controller: labelCtrl,
              decoration: inputDec(b, 'e.g. Tidying up toys after play'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Required' : null,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 15.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 16.h),
            fieldLabel(b, 'DESCRIPTION (OPTIONAL)'),
            SizedBox(height: 6.h),
            TextFormField(
              controller: descCtrl,
              minLines: 2,
              maxLines: 4,
              decoration: inputDec(b, 'Describe the behavior…'),
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 14.sp,
                color: b.ink,
              ),
            ),
            SizedBox(height: 16.h),
            fieldLabel(b, 'DIRECTION'),
            SizedBox(height: 8.h),
            Row(
              children: [
                _RadioChip(
                  label: 'Increasing',
                  selected: isIncreasing.value,
                  onTap: () => isIncreasing.value = true,
                  b: b,
                ),
                SizedBox(width: 10.w),
                _RadioChip(
                  label: 'Decreasing',
                  selected: !isIncreasing.value,
                  onTap: () => isIncreasing.value = false,
                  b: b,
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldLabel(b, 'BASELINE / DAY'),
                      SizedBox(height: 6.h),
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
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      fieldLabel(b, 'GOAL / DAY'),
                      SizedBox(height: 6.h),
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
              child: Text(
                'Next — set schedule',
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

  Widget fieldLabel(BrandPalette b, String text) => Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: b.ink3,
          letterSpacing: 0.6,
        ),
      );

  InputDecoration inputDec(BrandPalette b, String hint) => InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(fontFamily: 'Inter', color: b.ink4),
        filled: true,
        fillColor: b.card,
        contentPadding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
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
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 9.h),
          decoration: BoxDecoration(
            color: selected ? b.accent : b.card,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: selected ? b.accent : b.line),
          ),
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 13.sp,
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
            onPressed:
                value > min ? () => onChanged(value - 1) : null,
            icon: Icon(Icons.remove, size: 18.r),
            color: b.ink2,
            disabledColor: b.ink4,
          ),
          Text(
            '$value',
            style: TextStyle(
              fontFamily: 'IBMPlexMono',
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: b.ink,
            ),
          ),
          IconButton(
            onPressed:
                value < max ? () => onChanged(value + 1) : null,
            icon: Icon(Icons.add, size: 18.r),
            color: b.ink2,
            disabledColor: b.ink4,
          ),
        ],
      );
}
