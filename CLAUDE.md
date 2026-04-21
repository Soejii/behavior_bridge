# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project: BehaviorBridge

Flutter app (mobile + web) for parents and teachers tracking a child's behavior targets, daily logs, and reinforcement schedules. A deterministic analysis engine suggests the next move (keep observing, schedule upgrade, plateau, extinction risk, etc.). No auth, no backend, no cloud sync — local-first.

**Current State & Deviations from Original Spec:**
- The app is fully scaffolded and built using Clean Architecture.
- **Persistence:** Uses `SharedPreferences` (via `LocalStore`) instead of Hive.
- **Web Layout:** Uses a `ConstrainedBox` wrapper for web to mimic a sleek mobile device (similar to `pulse_flow`), ensuring pixel-perfect scaling using logical pixels. `flutter_screenutil` has been completely removed to avoid layout distortion.
- **Seed Data:** The `SeedUsecase` now generates 6 different targets for the subject "Maya", each seeded with specific data to trigger all 6 analysis states. This is no longer guarded by `kDebugMode` to ensure the demo works seamlessly in release builds.

## Commands

```bash
flutter pub get                    # install deps
flutter run                        # run on default device
flutter run -d chrome              # run web target
.\build_web.ps1                    # build web for deployment (outputs to docs/)
flutter build apk                  # build Android APK
flutter analyze                    # lint (flutter_lints preset)
flutter test                       # run all tests
dart run build_runner build --delete-conflicting-outputs   # regen freezed / json / riverpod code
```

## Architecture

Clean architecture **per feature**. Six features under `lib/features/`: `subject`, `behavior_target`, `reinforcement_schedule`, `daily_log`, `progress`, `analysis`.

Each feature follows: `data/{models,repositories,mappers,datasource}` · `domain/{entities,usecases}` · `presentation/{screens,widgets,providers}`. Shared UI in `lib/shared/`.

**State**: Riverpod with `riverpod_generator`. One provider per screen need.

**Persistence**: `SharedPreferences`, initialized in `main.dart`. Models use `freezed` + `json_serializable`.

**Routing**: `go_router`.

**Responsive**: Web uses a fixed-width `ConstrainedBox` (max 480px) to present a clean "mobile preview" layout in the browser without distortion.

### BehaviorAnalysisEngine

Pure Dart, no Flutter imports, at `lib/features/analysis/domain/usecase/behavior_analysis_engine.dart`. Takes `(logs, schedule)`, returns `AnalysisResult`. Checks conditions in this order:

1. `baseline` — ≤ 3 days logged
2. `goalReached` — last 7 days all ≥ goal
3. `extinctionRisk` — last 3 days with `reinforcementGiven == false`
4. `plateauDetected` — last 5 days within ±1 of each other, avg < goal − 1, schedule active ≥ 7d
5. `scheduleUpgrade` — CRF → FR-2 after 5+ consecutive days at goal with stddev < 1.5; FR → VR after 7 days at goal on FR
6. `onTrack` — default fallback

### Seed data

`SeedUsecase` loaded on first launch (persists a flag to run only once): creates subject "Maya" and 6 distinct targets mapping to the 6 analysis states using fixtures from `lib/features/analysis/data/fixtures.dart`.

## Design system

Tokens defined in `lib/app/theme/`. Key values: Inter (UI) + IBM Plex Mono (numerics/dates), accent `#3A5FCD` indigo, ink ramp, semantic ok/warn/risk each with a tint pairing. Employs a pixel-perfect `SuggestionScreen` and pure SVG-like `fl_chart` implementation.

## Out of scope

No authentication, no backend, no push notifications, no cloud sync, no punishment-based interventions, no media attachments on logs.
