import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/alerts/presentation/alerts_screen.dart';
import '../features/alerts/presentation/alert_setup_screen.dart';
import '../features/ask_ai/presentation/ask_ai_screen.dart';
import '../features/feed/presentation/feed_screen.dart';
import '../features/settings/presentation/settings_screen.dart';
import '../features/subnets/presentation/subnets_screen.dart';
import 'app_shell.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/feed',
    routes: [
      GoRoute(
        path: '/profile',
        redirect: (context, state) => '/settings',
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/feed',
                name: 'feed',
                builder: (context, state) => const FeedScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/subnets',
                name: 'subnets',
                builder: (context, state) => const SubnetsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/ask-ai',
                name: 'ask-ai',
                builder: (context, state) => const AskAiScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/alerts',
                name: 'alerts',
                builder: (context, state) => const AlertsScreen(),
                routes: [
                  GoRoute(
                    path: 'setup',
                    name: 'alert-setup',
                    builder: (context, state) => const AlertSetupScreen(),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/settings',
                name: 'settings',
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
