import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../infrastructure/providers/auth_providers.dart';
import '../../../infrastructure/providers/auth_state_providers.dart';
import '../../../../data/dummy_data.dart' show User;

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _usernameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    super.dispose();
  }

  Future<void> _onRegister() async {
    final username = _usernameCtrl.text.trim();
    final email = _emailCtrl.text.trim();
    final phone = _phoneCtrl.text.trim();
    final password = _passwordCtrl.text;
    final confirm = _confirmCtrl.text;

    final errors = <String>[];
    if (username.isEmpty || username.length < 3) {
      errors.add('Username must be at least 3 characters');
    }
    if (email.isEmpty || !email.toLowerCase().endsWith('@gmail.com')) {
      errors.add('Email must be a valid @gmail.com address');
    }
    // phone: + followed by 6-15 digits (basic international support)
    final phoneReg = RegExp(r'^\+\d{6,15}\$');
    if (phone.isEmpty || !phoneReg.hasMatch(phone)) {
      errors.add('Phone must start with + and include country code (e.g. +628123456789)');
    }
    if (password.length < 6) {
      errors.add('Password must be at least 6 characters');
    }
    if (password != confirm) {
      errors.add('Password and Confirm Password do not match');
    }

    if (errors.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(errors.join('\n'))));
      return;
    }

    setState(() => _isLoading = true);
    try {
      final repo = ref.read(authRepositoryProvider);
      // Mock register: use signIn to simulate network latency
      await repo.signIn(email, password);

      // Create a lightweight user object and sign in locally
      final id = 'u_custom_${DateTime.now().millisecondsSinceEpoch}';
      final user = User(
        id: id,
        username: username,
        displayName: username,
        avatarUrl: 'https://i.pravatar.cc/150?u=$id',
        email: email,
      );

      ref.read(authStateProvider.notifier).signInAs(user);

      if (!mounted) return;
      context.go('/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Register failed: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 12),
              TextField(
                controller: _usernameCtrl,
                decoration: const InputDecoration(hintText: 'Username'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(hintText: 'Email (must be @gmail.com)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(hintText: 'Phone (include + country code)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Password (min 6 chars)'),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _confirmCtrl,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Confirm Password'),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _onRegister,
                  child: _isLoading ? const CircularProgressIndicator.adaptive() : const Text('Sign Up'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
