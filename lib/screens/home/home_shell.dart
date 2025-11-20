import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';
import 'home_page.dart';
import '../lessons/lessons_screen.dart';
import '../tasks/tasks_screen.dart';
import '../profile/profile_screen.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _index = 0;
  String _userName = 'User';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is String && arguments.isNotEmpty) {
      _userName = arguments;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomePage(),
      const LessonsScreen(),
      const TasksScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      // Убираем AppBar, чтобы не было заголовка
      body: pages[_index],
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
          color: AppPalette.navy,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),
        child: NavigationBarTheme(
          data: const NavigationBarThemeData(
            indicatorColor: Colors.transparent,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            height: 56,
          ),
          child: NavigationBar(
            backgroundColor: Colors.transparent,
            selectedIndex: _index,
            onDestinationSelected: (i) => setState(() => _index = i),
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.home_outlined,
                  color: _index == 0 ? AppPalette.cyan1 : Colors.white,
                  size: 32,
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.menu_book_outlined,
                  color: _index == 1 ? AppPalette.cyan1 : Colors.white,
                  size: 32,
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.grid_view_outlined,
                  color: _index == 2 ? AppPalette.cyan1 : Colors.white,
                  size: 32,
                ),
                label: '',
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.person_outline,
                  color: _index == 3 ? AppPalette.cyan1 : Colors.white,
                  size: 32,
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
