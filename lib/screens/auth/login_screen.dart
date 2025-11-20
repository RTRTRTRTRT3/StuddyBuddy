import 'package:flutter/material.dart';
import '../../app_routes.dart';
import '../../services/user_service.dart';
import '../../theme/app_palette.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isLoginFailed = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Center(
                child: Image.asset(
                  'assets/photos/logo.png', // только логотип по центру
                  height: 60,
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppPalette.navy,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(18), // чуть острее
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Log In to continue',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 48),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _FieldLabel('Name'),
                            _AuthField(
                              controller: _name,
                              hint: 'Enter your name',
                              validator: _required,
                              hasError: _isLoginFailed,
                            ),
                            const SizedBox(height: 12),
                            const _FieldLabel('Email'),
                            _AuthField(
                              controller: _email,
                              hint: 'email@example.com',
                              keyboard: TextInputType.emailAddress,
                              validator: _required,
                              hasError: _isLoginFailed,
                            ),
                            const SizedBox(height: 12),
                            const _FieldLabel('Password'),
                            _AuthField(
                              controller: _password,
                              hint: '••••••••',
                              obscure: true,
                              validator: _required,
                              hasError: _isLoginFailed,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have account? ",
                                  style: TextStyle(color: Colors.white70),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.signup,
                                    );
                                  },
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      color: AppPalette.cyan2, // #81DFEE
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: AppPalette.navy,
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ), // текст больше
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      3,
                                    ), // еще острее
                                  ),
                                ),
                                onPressed: _onLogin,
                                child: const Text('Log In'),
                              ),
                            ),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  side: const BorderSide(color: Colors.white24),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ), // текст больше
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      3,
                                    ), // еще острее
                                  ),
                                ),
                                onPressed: _onGuest,
                                child: const Text('Guest Mode'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  void _onLogin() async {
    setState(() {
      _isLoginFailed = false; // Сбрасываем флаг ошибки перед попыткой входа
    });

    if (_formKey.currentState!.validate()) {
      final email = _email.text.trim();
      final password = _password.text.trim();

      print('DEBUG Login: Attempting login with email: $email');
      final success = await UserService.login(email, password);

      if (success) {
        final currentUser = await UserService.getCurrentUser();
        print('DEBUG Login: Login successful, user: ${currentUser?.name}');
        if (!mounted) return;

        Navigator.of(context).pushReplacementNamed(
          AppRoutes.home,
          arguments: currentUser?.name ?? 'User',
        );
      } else {
        print('DEBUG Login: Login failed');
        if (!mounted) return;
        setState(() {
          _isLoginFailed = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid email or password')),
        );
      }
    } else {
      _formKey.currentState!.save();
      setState(() {});
    }
  }

  void _onGuest() async {
    await UserService.setCurrentUser(null); // Убираем текущего пользователя для гостевого режима
    if (!mounted) return;

    Navigator.of(context).pushReplacementNamed(
      AppRoutes.home,
      arguments: 'Guest',
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String text;
  const _FieldLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _AuthField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboard;
  final bool obscure;
  final bool hasError;

  const _AuthField({
    required this.controller,
    required this.hint,
    this.validator,
    this.keyboard,
    this.obscure = false,
    this.hasError = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      style: const TextStyle(color: Colors.black), // черный текст
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.black38),
        filled: true,
        fillColor: const Color(0xFFE9ECF2),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // чуть острее
          borderSide: BorderSide(
            color: hasError ? Colors.red : Colors.transparent,
            width: hasError ? 2 : 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8), // чуть острее
          borderSide: BorderSide(
            color: hasError ? Colors.red : Colors.black26,
            width: hasError ? 2 : 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        errorStyle: const TextStyle(height: 0, fontSize: 0), // скрываем текст ошибок
      ),
    );
  }
}
