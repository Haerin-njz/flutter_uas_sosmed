import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Seed colors chosen for a modern Material 3 palette
  static const Color _seed = Color(0xFF6750A4); // deep purple seed

  static final ColorScheme lightScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.light,
  );

  static final ColorScheme darkScheme = ColorScheme.fromSeed(
    seedColor: _seed,
    brightness: Brightness.dark,
  );

  static final ThemeData light = ThemeData(
    useMaterial3: true,
    colorScheme: lightScheme,
    scaffoldBackgroundColor: lightScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: lightScheme.surface,
      foregroundColor: lightScheme.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(),
    iconTheme: IconThemeData(color: lightScheme.onSurface),
  );

  static final ThemeData dark = ThemeData(
    useMaterial3: true,
    colorScheme: darkScheme,
    scaffoldBackgroundColor: darkScheme.surface,
    appBarTheme: AppBarTheme(
      backgroundColor: darkScheme.surface,
      foregroundColor: darkScheme.onSurface,
      elevation: 0,
      centerTitle: false,
    ),
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData(brightness: Brightness.dark).textTheme,
    ),
    iconTheme: IconThemeData(color: darkScheme.onSurface),
  );
}
