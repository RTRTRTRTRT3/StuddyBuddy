import 'package:flutter/material.dart';
import '../../theme/app_palette.dart';

// Этот экран используется в HomeShell (без навигации)
class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const _TasksContent();
  }
}

// Этот экран используется при переходе с карточки (с навигацией)
class TasksDetailScreen extends StatefulWidget {
  const TasksDetailScreen({super.key});

  @override
  State<TasksDetailScreen> createState() => _TasksDetailScreenState();
}

class _TasksDetailScreenState extends State<TasksDetailScreen> {
  int _index = 2; // Tasks это третья вкладка (индекс 2)

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const _TasksContent(),
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
              if (i != 2) {
                // При нажатии на любую кнопку кроме Tasks - вернуться на главную
                Navigator.pop(context);
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

class _TasksContent extends StatelessWidget {
  const _TasksContent();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            // Заголовок UI прижатый к левому краю
            Transform.translate(
              offset: const Offset(-24, 0),
              child: _buildTitle('Task of ', 'UI course:'),
            ),
            const SizedBox(height: 34), // Увеличил расстояние между заголовком и первыми уроками с 12 до 24
            // Центрированные карточки UI
            Center(
              child: Column(
                children: [
                  // Первые два урока
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTaskCard('1st Lesson:', [
                        'What is Figma?',
                        'Interface overview',
                        'Creating your first file',
                      ], AppPalette.lightPurple),
                      _buildTaskCard('2nd Lesson:', [
                        'Drawing basic shapes',
                        'Understand the nesting',
                        'Grouping elements',
                      ], AppPalette.chipBlue),
                    ],
                  ),
                  const SizedBox(height: 24), // Расстояние между 1-2 и 3-4 уроками
                  // Вторые два урока
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTaskCard('3rd Lesson:', [
                        'Adding text',
                        'Applying font styles',
                        'Text auto-resize',
                      ], AppPalette.chipBlue),
                      _buildTaskCard('4th Lesson:', [
                        'Fill, stroke, opacity',
                        'Creating color styles',
                        'Using gradients',
                      ], AppPalette.lightPurple),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80), // Увеличил расстояние между группами с 60 до 80
            // Заголовок UX прижатый к левому краю
            Transform.translate(
              offset: const Offset(-24, 0),
              child: _buildTitle('Task of ', 'UX course:'),
            ),
            const SizedBox(height: 24), // Увеличил расстояние между заголовком и первыми уроками с 12 до 24
            // Центрированные карточки UX
            Center(
              child: Column(
                children: [
                  // Первые два урока
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTaskCard('1st Lesson:', [
                        'What is UX?',
                        'UX process overview',
                        'Good UX examples',
                      ], AppPalette.lightPurple),
                      _buildTaskCard('2nd Lesson:', [
                        'Personas',
                        'Empathy maps',
                        'User goal & pain point',
                      ], AppPalette.chipBlue),
                    ],
                  ),
                  const SizedBox(height: 20), // Расстояние между 1-2 и 3-4 уроками
                  // Вторые два урока
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _buildTaskCard('3rd Lesson:', [
                        'User flows',
                        'Step mapping',
                        'Mapping tools',
                      ], AppPalette.chipBlue),
                      _buildTaskCard('4th Lesson:', [
                        'Content organization',
                        'Card sorting',
                        'Usability structure',
                      ], AppPalette.lightPurple),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'About UI/UX Design',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, fontFamily: 'PublicSans'),
            ),
            const SizedBox(height: 12),
            const Text(
              'UI/UX design is about creating digital experiences that are both functional and visually engaging. UX (User Experience) focuses on how a product works — making sure it\'s useful, easy to use, and solves real problems. UI (User Interface) focuses on how a product looks — from typography and color to buttons and layout.',
              style: TextStyle(fontFamily: 'PublicSans'),
            ),
            const SizedBox(height: 32),
            SizedBox(
              height: 48, 
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPalette.purple, // Фиолетовый цвет
                  foregroundColor: Colors.white, // Белый текст
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('If you finish all tasks click it'),
              ),
            ),
          ],
        ),
    );
  }

  Widget _buildTitle(String a, String b) {
    return Container(
      width: 45,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      decoration: BoxDecoration(
        color: AppPalette.navy,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(12),
          bottomRight: Radius.circular(12),
        ),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 26,
            fontWeight: FontWeight.w900,
            fontFamily: 'PublicSans',
          ),
          children: [
            TextSpan(
              text: a,
              style: const TextStyle(fontWeight: FontWeight.normal), // Обычный вес для "Task of"
            ),
            TextSpan(
              text: b,
              style: const TextStyle(fontWeight: FontWeight.w800), // Жирный для "UI course" / "UX course"
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskCard(String title, List<String> lines, Color color) {
    return Container(
      width: 185, // увеличил ширину с 170 до 185
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18, fontFamily: 'PublicSans')),
          const SizedBox(height: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: lines.map((e) => Text(e, style: const TextStyle(height: 1.3))).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
