# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project: BehaviorBridge

Flutter app (mobile + web from the same widget tree) for parents and teachers tracking a child's behavior targets, daily logs, and reinforcement schedules. A deterministic analysis engine suggests the next move (keep observing, schedule upgrade, plateau, extinction risk, etc.). No auth, no backend, no cloud sync — local-first via Hive.

As of this writing, `lib/` still contains the default Flutter counter template. The canonical spec lives in `spec/handoff.html` (open in a browser, or read directly). `spec/BehaviorBridge.html` is the visual preview. **Read `spec/handoff.html` before scaffolding or modifying app code** — it defines the exact feature folders, data models, providers, routes, copy, and engine rules.

## Commands

```bash
flutter pub get                    # install deps
flutter run                        # run on default device
flutter run -d chrome              # run web target
flutter analyze                    # lint (flutter_lints preset)
flutter test                       # run all tests
flutter test test/foo_test.dart    # run a single test file
flutter test --name "engine plateau"   # run tests matching a name
dart run build_runner build --delete-conflicting-outputs   # regen freezed / json / riverpod code (once those deps are added)
```

Dart SDK ^3.5.0, Flutter 3.24. Android build note from `flutter create`: current Java version may exceed Gradle 7.6.3's supported range — if Android build breaks, adjust gradle-wrapper.properties or run `flutter config --jdk-dir=<path>`.

## Architecture

Clean architecture **per feature**, not global layers. Six features under `lib/features/`:

| Feature | Contains |
|---|---|
| `subject` | child/student profiles |
| `behavior_target` | the behavior being tracked (baseline, goal, increasing/decreasing) |
| `reinforcement_schedule` | CRF / FR-n / VR-n / interval schedules attached to a target |
| `daily_log` | one row per `(targetId, date)` with count + reinforcementGiven |
| `progress` | fl_chart views windowed 7d/14d/30d/all |
| `analysis` | `BehaviorAnalysisEngine` + `SuggestionScreen` |

Each feature follows: `data/{models,repositories}` · `domain/{entities,use_cases}` · `presentation/{screens,widgets,providers}`. Shared UI in `lib/shared/`.

**State**: Riverpod with `riverpod_generator`. One provider per screen need (e.g. `targetsBySubjectProvider(id)`, `analysisProvider(targetId)`).

**Persistence**: Hive, initialized in `main.dart`. Type adapters 1..4 for `Subject`, `BehaviorTarget`, `ReinforcementSchedule`, `DailyLog`. Models use `freezed` + `json_serializable`.

**Routing**: `go_router`. Routes listed in §7 of `handoff.html` — follow them verbatim.

**Responsive**: same widgets on mobile and web. `LayoutBuilder` at the screen root swaps to `DashboardLayout` (sidebar + main + right rail) at `maxWidth >= 800`, otherwise the mobile screen as-is.

### BehaviorAnalysisEngine

Pure Dart, no Flutter imports, at `lib/features/analysis/domain/use_cases/behavior_analysis_engine.dart`. Takes `(logs, schedule)`, returns `AnalysisResult`. Check these conditions **in this exact order** — first match wins:

1. `baseline` — fewer than 3 days logged
2. `goalReached` — last 7 days all ≥ goal
3. `extinctionRisk` — last 3 days with `reinforcementGiven == false`
4. `plateauDetected` — last 5 days within ±1 of each other, avg < goal − 1, schedule active ≥ 7d
5. `scheduleUpgrade` — CRF → FR-2 after 5+ consecutive days at goal with stddev < 1.5; FR → VR after 7 days at goal on FR
6. `onTrack` — default fallback

Headlines/explanations in the UI must come verbatim from the copy table in §4 of `handoff.html`. No psych jargon in user-facing strings.

### Seed data

Dev-only `SeedService` loaded on first launch under `kDebugMode`: creates subject "Maya" (6, parent) and target "Tidying up toys after play" (baseline 1, goal 4, increasing), plus 21 days of logs per preview state in `lib/features/analysis/data/fixtures.dart`. Keep these fixtures in sync with the 6 engine statuses — they're how we verify the engine end-to-end.

## Design system

Tokens defined in §1 of `handoff.html`. Implement in `lib/shared/theme/`. Key values: Inter (UI) + IBM Plex Mono (numerics/dates), accent `#3A5FCD` indigo, ink ramp `#0E1420 / #32405A / #5F6B82 / #8A94A8`, bg `#F6F7FB`, semantic ok/warn/risk each with a tint pairing, radii 6/10/14/20/999, two density modes (`comfortable` default, `compact` 0.85× padding).

## Out of scope

No authentication, no backend, no push notifications, no cloud sync, no punishment-based interventions, no media attachments on logs.
