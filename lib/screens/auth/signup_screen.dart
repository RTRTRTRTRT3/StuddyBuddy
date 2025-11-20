import 'package:flutter/material.dart';
import '../../app_routes.dart';
import '../../services/user_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _hasValidationError = false;

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
              flex: 7, // 70%
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF071A36),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Create an account',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'sign up to continue',
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
                              hint: 'Kaussar',
                              validator: _required,
                              hasError: _hasValidationError,
                            ),
                            const SizedBox(height: 12),
                            const _FieldLabel('Email'),
                            _AuthField(
                              controller: _email,
                              hint: 'email@example.com',
                              keyboard: TextInputType.emailAddress,
                              validator: _required,
                              hasError: _hasValidationError,
                            ),
                            const SizedBox(height: 12),
                            const _FieldLabel('Password'),
                            _AuthField(
                              controller: _password,
                              hint: '••••••••••',
                              obscure: true,
                              validator: _required,
                              hasError: _hasValidationError,
                            ),
                            const SizedBox(height: 16),
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'already have an account? ',
                                    style: TextStyle(color: Colors.white70),
                                  ),
                                  GestureDetector(
                                    onTap: () => Navigator.pushReplacementNamed(
                                      context,
                                      AppRoutes.login,
                                    ),
                                    child: Text(
                                      'Log In',
                                      style: TextStyle(
                                        color: Color(0xFF81DFEE), // cyan2
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            SizedBox(
                              width: double.infinity,
                              height: 48,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: const Color(0xFF071A36),
                                  textStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      3,
                                    ), // острее
                                  ),
                                ),
                                onPressed: _onSignUp,
                                child: const Text('Sign Up'),
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
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      3,
                                    ), // острее
                                  ),
                                ),
                                onPressed: () async {
                                  await UserService.setCurrentUser(null); // Убираем текущего пользователя для гостевого режима
                                  Navigator.pushReplacementNamed(
                                    context,
                                    AppRoutes.home,
                                    arguments: 'Guest',
                                  );
                                },
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

  String? _required(String? v) =>
      (v == null || v.trim().isEmpty) ? 'This field is required' : null;

  void _onSignUp() async {
    setState(() {
      _hasValidationError = false; // Сбрасываем флаг ошибки перед попыткой регистрации
    });

    if (_formKey.currentState!.validate()) {
      final name = _name.text.trim();
      final email = _email.text.trim();
      final password = _password.text.trim();

      print('DEBUG SignUp: Saving user with name: $name, email: $email');
      final user = User(name: name, email: email, password: password);
      await UserService.saveUser(user);
      await UserService.setCurrentUser(user);
      
      // Проверяем, что пользователь сохранился
      final savedUser = await UserService.getCurrentUser();
      print('DEBUG SignUp: Current user after save: ${savedUser?.name}');

      if (!mounted) return;

      Navigator.pushReplacementNamed(
        context,
        AppRoutes.home,
        arguments: name,
      );
    } else {
      setState(() {
        _hasValidationError = true; // Устанавливаем флаг ошибки при неудачной валидации
      });
      _formKey.currentState!.save();
    }
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
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: hasError ? Colors.red : Colors.transparent,
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
