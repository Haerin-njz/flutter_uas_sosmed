import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/infrastructure/providers/auth_state_provider.dart';
import 'router.dart' as app_router;
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ProviderScope(child: UasApp()));
}

class UasApp extends ConsumerWidget {
  const UasApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final base = ThemeData.dark(useMaterial3: true);
    final theme = base.copyWith(
      scaffoldBackgroundColor: const Color(0xFF000000),
      colorScheme: base.colorScheme.copyWith(
        primary: const Color(0xFF405DE6), // Instagram blue
        secondary: const Color(0xFFC13584), // Instagram pink
        surface: const Color(0xFF121212),
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme)
          .apply(bodyColor: Colors.white, displayColor: Colors.white)
          .copyWith(
            headlineSmall: GoogleFonts.inter(
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            titleLarge: GoogleFonts.inter(
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: GoogleFonts.inter(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 20,
        ),
      ),
      cardTheme: base.cardTheme.copyWith(
        color: const Color(0xFF1E1E1E),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: const Color(0xFF2A2A2A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: Colors.grey),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF405DE6),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );

    final signedIn = ref.watch(authStateProvider) != null;
    final router = app_router.createRouter(signedIn: signedIn);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: router,
      title: 'Instagram Clone',
    );
  }
}
