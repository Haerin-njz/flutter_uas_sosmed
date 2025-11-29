import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // simple simulated startup delay then navigate to home
    Future.delayed(const Duration(milliseconds: 800), () {
      // In future we'll check auth state and route accordingly
      if (!mounted) return;
      GoRouter.of(context).go('/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.camera_alt_outlined, size: 64, color: color),
            const SizedBox(height: 12),
            Text('UAS Social', style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
