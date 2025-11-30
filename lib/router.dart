import 'package:go_router/go_router.dart';
import 'navigation_container.dart';
import 'screens/home_screen.dart';
import 'screens/search_screen.dart';
import 'screens/add_screen.dart';
import 'screens/reels_screen.dart';
import 'screens/profile_screen.dart';
import 'src/presentation/pages/notifications/notifications_screen.dart';
import 'src/presentation/pages/messages/conversations_screen.dart';
import 'src/presentation/pages/auth/login_screen.dart';
import 'src/presentation/pages/auth/register_screen.dart';

GoRouter createRouter({required bool signedIn}) {
  return GoRouter(
    initialLocation: signedIn ? '/home' : '/login',
    redirect: (context, state) {
      // Allow unauthenticated users to access the login and register pages.
      final publicPaths = ['/login', '/register'];
      final goingToPublic = publicPaths.contains(state.location);
      if (!signedIn && !goingToPublic) return '/login';
      if (signedIn && goingToPublic) return '/home';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/notifications',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const NotificationsScreen()),
      ),
      GoRoute(
        path: '/messages',
        pageBuilder: (context, state) =>
            NoTransitionPage(child: const ConversationsScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/search',
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const SearchScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/add',
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const AddScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/reels',
                pageBuilder: (context, state) =>
                    NoTransitionPage(child: const ReelsScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: const ProfileScreen(userId: 'user_1'),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
