import 'package:flutter/material.dart';
import 'screens/auth/first_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/signup_screen.dart';
import 'screens/home/home_shell.dart';
import 'screens/course/course_overview_screen.dart';
import 'screens/tasks/tasks_screen.dart';
import 'screens/profile/plans_screen.dart';
import 'screens/profile/payment_screen.dart';

class AppRoutes {
  static const String first = '/';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String home = '/home';
  static const String courseOverview = '/course';
  static const String tasks = '/tasks';
  static const String tasksDetail = '/tasks-detail';
  static const String plans = '/plans';
  static const String payment = '/payment';

  static Map<String, WidgetBuilder> buildAppRoutes() {
    return {
      first: (context) => const FirstScreen(),
      login: (context) => const LoginScreen(),
      signup: (context) => const SignUpScreen(),
      home: (context) => const HomeShell(),
      courseOverview: (context) => const CourseOverviewScreen(),
      tasks: (context) => const TasksScreen(),
      tasksDetail: (context) => const TasksDetailScreen(),
      plans: (context) => const PlansScreen(),
      payment: (context) => const PaymentScreen(planName: 'Unknown'),
    };
  }
}
