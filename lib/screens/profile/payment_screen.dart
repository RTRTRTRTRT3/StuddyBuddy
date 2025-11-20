import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';

class PaymentScreen extends StatefulWidget {
  final String planName;
  const PaymentScreen({super.key, required this.planName});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _cardNumber = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _phone = TextEditingController();

  @override
  void dispose() {
    _cardNumber.dispose();
    _password.dispose();
    _phone.dispose();
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
                  'assets/photos/logo.png',
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
                    top: Radius.circular(18),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Payment for ${widget.planName}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Padding(
                      padding: EdgeInsets.only(left: 56),
                      child: Text(
                        'Enter your payment details',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    const SizedBox(height: 48),
                    Expanded(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const _FieldLabel('Your card number'),
                            _PaymentField(
                              controller: _cardNumber,
                              hint: '1234 5678 9012 3456',
                              keyboard: TextInputType.number,
                            ),
                            const SizedBox(height: 12),
                            const _FieldLabel('Your password'),
                            _PaymentField(
                              controller: _password,
                              hint: '••••••••',
                              obscure: true,
                            ),
                            const SizedBox(height: 12),
                            const _FieldLabel('Your phone'),
                            _PaymentField(
                              controller: _phone,
                              hint: '+7 (___) ___-__-__',
                              keyboard: TextInputType.phone,
                            ),
                            const Spacer(),
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
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                onPressed: _onPayment,
                                child: const Text('Confirm Payment'),
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
                                    borderRadius: BorderRadius.circular(3),
                                  ),
                                ),
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
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

  void _onPayment() {
    if (_formKey.currentState!.validate()) {
      // Показываем успешное сообщение
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Payment successful for ${widget.planName} plan!'),
          backgroundColor: Colors.green,
        ),
      );
      // Возвращаемся назад
      Navigator.pop(context);
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

class _PaymentField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboard;
  final bool obscure;

  const _PaymentField({
    required this.controller,
    required this.hint,
    this.keyboard,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboard,
      obscureText: obscure,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white38),
        filled: true,
        fillColor: AppPalette.navy,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 1),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
