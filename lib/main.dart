import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_routes.dart';
import 'services/user_service.dart';

void main() {
  runApp(const StuddyBuddyApp());
}




class StuddyBuddyApp extends StatelessWidget {
  const StuddyBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StuddyBuddy',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7B61FF),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF2F4F7),
        useMaterial3: true,
        textTheme: GoogleFonts.interTextTheme(),
        // Для заголовков используем Public Sans
        primaryTextTheme: GoogleFonts.publicSansTextTheme(),
        // Добавляем плавные переходы между страницами
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),  
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
            TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          },
        ),
      ),
      initialRoute: AppRoutes.first,
      routes: AppRoutes.buildAppRoutes(),
    );
  }
}
