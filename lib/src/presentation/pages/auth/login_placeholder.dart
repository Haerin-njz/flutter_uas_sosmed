import 'package:flutter/material.dart';

class LoginPlaceholder extends StatelessWidget {
  const LoginPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login (placeholder)')),
      body: const Center(child: Text('Login flow will be implemented in Phase 2')),
    );
  }
}
