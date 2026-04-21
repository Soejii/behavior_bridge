import 'package:flutter/material.dart';
import 'package:behavior_bridge/shared/core/constant/app_colors.dart';

@immutable
class BrandPalette extends ThemeExtension<BrandPalette> {
  // neutrals
  final Color ink;
  final Color ink2;
  final Color ink3;
  final Color ink4;
  final Color line;
  final Color line2;
  final Color bg;
  final Color bgDeep;
  final Color card;

  // accent
  final Color accent;
  final Color accentTint;
  final Color accentTintDeep;
  final Color accentFg;

  // semantic
  final Color ok;
  final Color okTint;
  final Color okDark;
  final Color warn;
  final Color warnTint;
  final Color warnDark;
  final Color risk;
  final Color riskTint;

  // shadows
  final List<BoxShadow> sh1;
  final List<BoxShadow> sh2;

  const BrandPalette({
    required this.ink,
    required this.ink2,
    required this.ink3,
    required this.ink4,
    required this.line,
    required this.line2,
    required this.bg,
    required this.bgDeep,
    required this.card,
    required this.accent,
    required this.accentTint,
    required this.accentTintDeep,
    required this.accentFg,
    required this.ok,
    required this.okTint,
    required this.okDark,
    required this.warn,
    required this.warnTint,
    required this.warnDark,
    required this.risk,
    required this.riskTint,
    required this.sh1,
    required this.sh2,
  });

  factory BrandPalette.defaults() => const BrandPalette(
        ink: AppColors.ink,
        ink2: AppColors.ink2,
        ink3: AppColors.ink3,
        ink4: AppColors.ink4,
        line: AppColors.line,
        line2: AppColors.line2,
        bg: AppColors.bg,
        bgDeep: AppColors.bgDeep,
        card: AppColors.card,
        accent: AppColors.accent,
        accentTint: AppColors.accentTint,
        accentTintDeep: AppColors.accentTintDeep,
        accentFg: AppColors.accentFg,
        ok: AppColors.ok,
        okTint: AppColors.okTint,
        okDark: AppColors.okDark,
        warn: AppColors.warn,
        warnTint: AppColors.warnTint,
        warnDark: AppColors.warnDark,
        risk: AppColors.risk,
        riskTint: AppColors.riskTint,
        sh1: AppColors.sh1,
        sh2: AppColors.sh2,
      );

  factory BrandPalette.fromConfig(Map<String, dynamic> colors) {
    final d = BrandPalette.defaults();
    Color hex(String? v, Color fb) {
      if (v == null || v.isEmpty) return fb;
      var h = v.replaceAll('#', '');
      if (h.length == 6) h = 'FF$h';
      return Color(int.parse(h, radix: 16));
    }

    return BrandPalette(
      ink: hex(colors['ink'] as String?, d.ink),
      ink2: hex(colors['ink2'] as String?, d.ink2),
      ink3: hex(colors['ink3'] as String?, d.ink3),
      ink4: hex(colors['ink4'] as String?, d.ink4),
      line: hex(colors['line'] as String?, d.line),
      line2: hex(colors['line2'] as String?, d.line2),
      bg: hex(colors['bg'] as String?, d.bg),
      bgDeep: hex(colors['bgDeep'] as String?, d.bgDeep),
      card: hex(colors['card'] as String?, d.card),
      accent: hex(colors['accent'] as String?, d.accent),
      accentTint: hex(colors['accentTint'] as String?, d.accentTint),
      accentTintDeep:
          hex(colors['accentTintDeep'] as String?, d.accentTintDeep),
      accentFg: hex(colors['accentFg'] as String?, d.accentFg),
      ok: hex(colors['ok'] as String?, d.ok),
      okTint: hex(colors['okTint'] as String?, d.okTint),
      okDark: hex(colors['okDark'] as String?, d.okDark),
      warn: hex(colors['warn'] as String?, d.warn),
      warnTint: hex(colors['warnTint'] as String?, d.warnTint),
      warnDark: hex(colors['warnDark'] as String?, d.warnDark),
      risk: hex(colors['risk'] as String?, d.risk),
      riskTint: hex(colors['riskTint'] as String?, d.riskTint),
      sh1: d.sh1,
      sh2: d.sh2,
    );
  }

  @override
  BrandPalette copyWith({
    Color? ink,
    Color? ink2,
    Color? ink3,
    Color? ink4,
    Color? line,
    Color? line2,
    Color? bg,
    Color? bgDeep,
    Color? card,
    Color? accent,
    Color? accentTint,
    Color? accentTintDeep,
    Color? accentFg,
    Color? ok,
    Color? okTint,
    Color? okDark,
    Color? warn,
    Color? warnTint,
    Color? warnDark,
    Color? risk,
    Color? riskTint,
    List<BoxShadow>? sh1,
    List<BoxShadow>? sh2,
  }) =>
      BrandPalette(
        ink: ink ?? this.ink,
        ink2: ink2 ?? this.ink2,
        ink3: ink3 ?? this.ink3,
        ink4: ink4 ?? this.ink4,
        line: line ?? this.line,
        line2: line2 ?? this.line2,
        bg: bg ?? this.bg,
        bgDeep: bgDeep ?? this.bgDeep,
        card: card ?? this.card,
        accent: accent ?? this.accent,
        accentTint: accentTint ?? this.accentTint,
        accentTintDeep: accentTintDeep ?? this.accentTintDeep,
        accentFg: accentFg ?? this.accentFg,
        ok: ok ?? this.ok,
        okTint: okTint ?? this.okTint,
        okDark: okDark ?? this.okDark,
        warn: warn ?? this.warn,
        warnTint: warnTint ?? this.warnTint,
        warnDark: warnDark ?? this.warnDark,
        risk: risk ?? this.risk,
        riskTint: riskTint ?? this.riskTint,
        sh1: sh1 ?? this.sh1,
        sh2: sh2 ?? this.sh2,
      );

  @override
  BrandPalette lerp(ThemeExtension<BrandPalette>? other, double t) {
    if (other is! BrandPalette) return this;
    Color l(Color a, Color b) => Color.lerp(a, b, t)!;
    return BrandPalette(
      ink: l(ink, other.ink),
      ink2: l(ink2, other.ink2),
      ink3: l(ink3, other.ink3),
      ink4: l(ink4, other.ink4),
      line: l(line, other.line),
      line2: l(line2, other.line2),
      bg: l(bg, other.bg),
      bgDeep: l(bgDeep, other.bgDeep),
      card: l(card, other.card),
      accent: l(accent, other.accent),
      accentTint: l(accentTint, other.accentTint),
      accentTintDeep: l(accentTintDeep, other.accentTintDeep),
      accentFg: l(accentFg, other.accentFg),
      ok: l(ok, other.ok),
      okTint: l(okTint, other.okTint),
      okDark: l(okDark, other.okDark),
      warn: l(warn, other.warn),
      warnTint: l(warnTint, other.warnTint),
      warnDark: l(warnDark, other.warnDark),
      risk: l(risk, other.risk),
      riskTint: l(riskTint, other.riskTint),
      sh1: sh1,
      sh2: sh2,
    );
  }
}

extension BrandX on BuildContext {
  BrandPalette get brand => Theme.of(this).extension<BrandPalette>()!;
}
