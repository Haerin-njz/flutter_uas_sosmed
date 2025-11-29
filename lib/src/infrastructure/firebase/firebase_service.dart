import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

/// Helper to initialize Firebase safely at runtime.
///
/// This is a lightweight utility that tries to call [Firebase.initializeApp]
/// and returns whether Firebase is usable. It wraps initialization in
/// try/catch so the app can safely run in environments where Firebase is
/// not configured yet (no google-services.json / GoogleService-Info.plist).
class FirebaseService {
  static bool _initialized = false;

  /// Returns whether Firebase initialization succeeded.
  static bool get isInitialized => _initialized;

  /// Attempt to initialize Firebase. Returns true when ready.
  ///
  /// Call this early in the app (if you plan to enable Firebase). If you do
  /// not configure Firebase, this will catch and swallow errors and return
  /// false so the app continues to work with mock providers.
  static Future<bool> initializeIfPossible() async {
    if (_initialized) return true;

    try {
      // Safe to call even if there are no platform configs; it may still
      // throw – we'll catch that and return false.
      await Firebase.initializeApp();
      _initialized = true;
      return true;
    } catch (err, stack) {
      // In development and when using the mock backend, initialization will
      // likely fail. We log for debugging but don't rethrow so consumers
      // can continue using local/mock implementations.
      if (kDebugMode) {
        // ignore: avoid_print
        print('Firebase initialize failed: $err\n$stack');
      }
      return false;
    }
  }
}
