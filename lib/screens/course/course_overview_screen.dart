import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';
import '../home/home_page.dart';
import '../lessons/lessons_screen.dart';
import '../tasks/tasks_screen.dart';
import '../profile/profile_screen.dart';

class CourseOverviewScreen extends StatefulWidget {
  const CourseOverviewScreen({super.key});

  @override
  State<CourseOverviewScreen> createState() => _CourseOverviewScreenState();
}

class _CourseOverviewScreenState extends State<CourseOverviewScreen> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const _CourseOverviewContent(),
      const LessonsScreen(),
      const TasksScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
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
            onDestinationSelected: (i) {
              if (i == 0 && _index == 0) {
                // Если уже на странице Course Overview и нажали Home - вернуться на главную
                Navigator.pop(context);
              } else {
                setState(() => _index = i);
              }
            },
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

class _CourseOverviewContent extends StatelessWidget {
  const _CourseOverviewContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Padding(
              padding: const EdgeInsets.all(24),
              child: Row(
                children: [
                  IconButton(
                    style: IconButton.styleFrom(backgroundColor: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  const SizedBox(width: 8),
                  const Text('Course Overview', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            _courseCard('Figma master class', 'UI design  (5 lessons)', '2h 30min', '4.9', 'Dive into the world of UI design with our hands-on Figma Master Class — the most popular tool for designing modern interface.', 'assets/photos/asdasd.png'),
            const SizedBox(height: 56),
            _courseCard('UX design basics', 'UX design  (8 lessons)', '3h 45min', '4.8', 'Master the fundamentals of user experience design and learn how to create intuitive and user-friendly interfaces.', 'assets/photos/ds.png'),
            const SizedBox(height: 56),
            _courseCard('Adobe XD essentials', 'UI design  (6 lessons)', '2h 15min', '4.7', 'Learn Adobe XD from scratch and create stunning prototypes and designs for web and mobile applications.', 'assets/photos/vxz.png'),
            const SizedBox(height: 56),
            _courseCard('Prototyping pro', 'Prototyping  (4 lessons)', '1h 50min', '4.9', 'Take your prototyping skills to the next level with advanced techniques and interactive animations.', 'assets/photos/unsplash_jxelyjTrWFgdsas.png'),
            const SizedBox(height: 24),
          ],
        ),
    );
  }

  Widget _courseCard(String title, String subtitle, String duration, String rating, String description, String imagePath) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Container(
              height: 240,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            Text(subtitle),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Chip(icon: Icons.access_time, text: duration),
                Row(
                  children: [
                    const Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(rating),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16),
            Transform.translate(
              offset: const Offset(-24, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: const BoxDecoration(
                  color: Color(0xFF7B61FF),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
                child: const Text(
                  'Course Description',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(description),
          ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Chip({required this.icon, required this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: const Color(0xFFD4EEF7), borderRadius: BorderRadius.circular(8)),
      child: Row(children: [Icon(icon, size: 16), const SizedBox(width: 6), Text(text)]),
    );
  }
}

