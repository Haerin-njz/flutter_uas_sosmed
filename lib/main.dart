import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'navigation_container.dart';
import 'features/posts/presentation/add_post_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter router = GoRouter(
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) =>
          ScaffoldWithNavBar(navigationShell: navigationShell),
      branches: [
        // HOME
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/home',
              builder: (context, state) =>
                  const Center(child: Text("Home")),
            ),
          ],
        ),

        // SEARCH
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/search',
              builder: (context, state) =>
                  const Center(child: Text("Search")),
            ),
          ],
        ),

        // ADD
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/add',
              builder: (context, state) => const AddPostScreen(),
            ),
          ],
        ),

        // REELS
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/reels',
              builder: (context, state) =>
                  const Center(child: Text("Reels")),
            ),
          ],
        ),

        // PROFILE
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) =>
                  const Center(child: Text("Profile")),
            ),
          ],
        ),
      ],
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
    );
  }
}
