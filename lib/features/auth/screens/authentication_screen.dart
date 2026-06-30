import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_provider.dart';

class AuthenticationScreen extends StatefulWidget {
  const AuthenticationScreen({super.key});

  @override
  State<AuthenticationScreen> createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  final _emailController = TextEditingController(text: 'operator@smartid.pro');
  final _pinController = TextEditingController(text: '1234');

  @override
  void dispose() {
    _emailController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, provider, child) {
        return Row(
          children: [
            Expanded(flex: 5, child: _SessionPanel(provider: provider)),
            const SizedBox(width: 18),
            Expanded(
              flex: 5,
              child: _SignInPanel(
                emailController: _emailController,
                pinController: _pinController,
                provider: provider,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _SessionPanel extends StatelessWidget {
  const _SessionPanel({required this.provider});

  final AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    final user = provider.user;

    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'AUTHENTICATION',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 22),
            CircleAvatar(
              radius: 42,
              backgroundColor: const Color(0xFFD4A64A),
              child: Text(
                user?.initials ?? '?',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              user?.displayName ?? 'Signed out',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              user?.role ?? 'No active session',
              style: const TextStyle(color: Colors.white60),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: user == null || provider.loading
                    ? null
                    : provider.signOut,
                icon: const Icon(Icons.logout),
                label: const Text('SIGN OUT'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SignInPanel extends StatelessWidget {
  const _SignInPanel({
    required this.emailController,
    required this.pinController,
    required this.provider,
  });

  final TextEditingController emailController;
  final TextEditingController pinController;
  final AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _panelDecoration(),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'OPERATOR LOGIN',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 18),
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: _inputDecoration('Email'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pinController,
              obscureText: true,
              decoration: _inputDecoration('PIN'),
            ),
            if (provider.error != null) ...[
              const SizedBox(height: 12),
              Text(
                provider.error!,
                style: const TextStyle(color: Color(0xFFF87171)),
              ),
            ],
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                onPressed: provider.loading
                    ? null
                    : () => provider.signIn(
                        email: emailController.text,
                        pin: pinController.text,
                      ),
                icon: const Icon(Icons.login),
                label: const Text('SIGN IN'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFF1F2937),
      border: const OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
    );
  }
}

BoxDecoration _panelDecoration() {
  return BoxDecoration(
    color: const Color(0xFF111827),
    borderRadius: BorderRadius.circular(24),
    border: Border.all(color: const Color.fromRGBO(255, 255, 255, .06)),
  );
}
