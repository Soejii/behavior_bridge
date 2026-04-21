import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:behavior_bridge/features/analysis/presentation/screens/suggestion_screen.dart';
import 'package:behavior_bridge/features/behavior_target/presentation/screens/create_target_screen.dart';
import 'package:behavior_bridge/features/daily_log/presentation/screens/daily_log_screen.dart';
import 'package:behavior_bridge/features/home/presentation/screens/home_screen.dart';
import 'package:behavior_bridge/features/progress/presentation/screens/dashboard_layout_screen.dart';
import 'package:behavior_bridge/features/progress/presentation/screens/progress_screen.dart';
import 'package:behavior_bridge/features/reinforcement_schedule/presentation/screens/schedule_setup_screen.dart';
import 'package:behavior_bridge/features/subject/presentation/screens/create_subject_screen.dart';
import 'package:behavior_bridge/features/subject/presentation/screens/subject_detail_screen.dart';
import 'package:behavior_bridge/shared/core/infrastructure/routes/route_name.dart';
import 'package:behavior_bridge/shared/screens/error_screen.dart';

part 'app_router.g.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) => GoRouter(
      navigatorKey: rootNavigatorKey,
      initialLocation: '/',
      debugLogDiagnostics: kDebugMode,
      errorBuilder: (_, state) =>
          ErrorScreen(error: state.error ?? Exception('Unknown router error')),
      routes: [
        GoRoute(
          path: '/',
          name: RouteName.home,
          builder: (_, __) => const HomeScreen(),
          routes: [
            GoRoute(
              path: 'subjects/new',
              name: RouteName.createSubject,
              parentNavigatorKey: rootNavigatorKey,
              builder: (_, __) => const CreateSubjectScreen(),
            ),
            GoRoute(
              path: 'subjects/:subjectId',
              name: RouteName.subjectDetail,
              parentNavigatorKey: rootNavigatorKey,
              builder: (_, state) {
                final subjectId = state.pathParameters['subjectId']!;
                final targetId = state.uri.queryParameters['targetId'];
                return LayoutBuilder(
                  builder: (ctx, constraints) => constraints.maxWidth >= 800
                      ? DashboardLayoutScreen(
                          subjectId: subjectId,
                          targetId: targetId,
                        )
                      : SubjectDetailScreen(subjectId: subjectId),
                );
              },
              routes: [
                GoRoute(
                  path: 'targets/new',
                  name: RouteName.createTarget,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (_, state) => CreateTargetScreen(
                    subjectId: state.pathParameters['subjectId']!,
                  ),
                ),
              ],
            ),
            GoRoute(
              path: 'targets/:targetId/schedule',
              name: RouteName.scheduleSetup,
              parentNavigatorKey: rootNavigatorKey,
              builder: (_, state) => ScheduleSetupScreen(
                targetId: state.pathParameters['targetId']!,
              ),
            ),
            GoRoute(
              path: 'targets/:targetId/log',
              name: RouteName.dailyLog,
              parentNavigatorKey: rootNavigatorKey,
              builder: (_, state) => DailyLogScreen(
                targetId: state.pathParameters['targetId']!,
              ),
            ),
            GoRoute(
              path: 'targets/:targetId/progress',
              name: RouteName.progress,
              parentNavigatorKey: rootNavigatorKey,
              builder: (_, state) => ProgressScreen(
                targetId: state.pathParameters['targetId']!,
              ),
            ),
            GoRoute(
              path: 'targets/:targetId/suggestion',
              name: RouteName.suggestion,
              parentNavigatorKey: rootNavigatorKey,
              builder: (_, state) => SuggestionScreen(
                targetId: state.pathParameters['targetId']!,
              ),
            ),
          ],
        ),
      ],
    );
