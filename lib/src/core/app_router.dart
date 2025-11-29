import 'package:go_router/go_router.dart';
import '../presentation/pages/splash/splash_screen.dart';
import '../presentation/pages/home/feed_screen.dart';
import '../presentation/pages/profile/profile_screen.dart';
import '../presentation/pages/auth/login_screen.dart';
import '../presentation/pages/stories/stories_screen.dart';
import '../presentation/pages/search/search_screen.dart';
import '../presentation/pages/explore/explore_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: <GoRoute>[
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const FeedScreen(),
      ),
      GoRoute(
        path: '/stories',
        name: 'stories',
        builder: (context, state) => const StoriesScreen(),
      ),
      GoRoute(
        path: '/search',
        name: 'search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/explore',
        name: 'explore',
        builder: (context, state) => const ExploreScreen(),
      ),
      GoRoute(
        path: '/profile/:id',
        name: 'profile',
        builder: (context, state) {
          final id = state.pathParameters['id'] ?? 'user_1';
          return ProfileScreen(userId: id);
        },
      ),
    ],
  );
}
