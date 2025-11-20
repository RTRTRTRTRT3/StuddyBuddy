import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';
import 'payment_screen.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPalette.bg,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Header
            Row(
              children: [
                IconButton(
                  style: IconButton.styleFrom(backgroundColor: Colors.white),
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
                const SizedBox(width: 8),
                const Text(
                  'Choose Your Plan',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Free Plan Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Free',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppPalette.navy,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '/ month',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Colors.grey[400],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  _buildFeature('Access to courses', isPremium: false),
                  _buildFeature('Free video tutorials', isPremium: false),
                  _buildFeature('Web and mobile app access', isPremium: false),
                  _buildFeature('Student community / forum', isPremium: false),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDD835),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentScreen(planName: 'Free'),
                              ),
                            );
                          },
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            child: Text(
                              'Choose plan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppPalette.navy,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Premium Plan Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppPalette.lightPurple,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Premium',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: AppPalette.navy,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          '/ month',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: AppPalette.navy,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '5990 tg',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: AppPalette.navy,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildFeature('All Free features', isPremium: true),
                  _buildFeature('Unlimited course access', isPremium: true),
                  _buildFeature('Premium video content', isPremium: true),
                  _buildFeature('1-on-1 mentorship', isPremium: true),
                  _buildFeature('Certificate of completion', isPremium: true),
                  _buildFeature('Priority support', isPremium: true),
                  const SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDD835),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(50),
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                          bottomLeft: Radius.circular(16),
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const PaymentScreen(planName: 'Premium'),
                              ),
                            );
                          },
                          borderRadius: const BorderRadius.only(
                            bottomRight: Radius.circular(50),
                            topLeft: Radius.circular(16),
                            topRight: Radius.circular(16),
                            bottomLeft: Radius.circular(16),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            child: Text(
                              'Choose plan',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppPalette.navy,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeature(String text, {required bool isPremium}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: isPremium ? AppPalette.purple : AppPalette.lightPurple,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.check,
              color: isPremium ? AppPalette.navy : Colors.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 16,
                color: AppPalette.navy,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
