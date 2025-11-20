import 'package:flutter/material.dart';
import '../../app_routes.dart';
import '../../services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _userName = 'User';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final user = await UserService.getCurrentUser();
    print('DEBUG: Current user loaded: ${user?.name ?? "null"}');
    if (user != null && user.name.isNotEmpty) {
      setState(() {
        _userName = user.name;
      });
    } else {
      print('DEBUG: User is null or name is empty');
    }
  }

  @override
  Widget build(BuildContext context) {
    final PageController _pageController = PageController(viewportFraction: 0.6);

    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                // Приветствие с именем пользователя
                Text(
                  'Hi, $_userName',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF071A36),
                  ),
                ),
                const SizedBox(height: 12),
                const Text('Find your lessons today'),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'search now...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD4E7F7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.tune),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _banner(context),
                const SizedBox(height: 52),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Popular lessons',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, AppRoutes.courseOverview),
                      child: const Text(
                        'See All',
                        style: TextStyle(
                          color: Color(0xFF7B61FF),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            child: PageView.builder(
              controller: _pageController,
              itemCount: 9,
              physics: const BouncingScrollPhysics(),
              padEnds: false,
              itemBuilder: (context, i) {
                final images = [
                  'assets/photos/asdasd.png',
                  'assets/photos/ds.png',
                  'assets/photos/vxz.png',
                  'assets/photos/unsplash_jxelyjTrWFgdsas.png',
                  'assets/photos/unsplash_jxelyjTrWFg.png',
                  'assets/photos/unsplash_c8h0n7fSTqs.png',
                  'assets/photos/unsplash_c8h0n7fSTqsq@2x.png',
                  'assets/photos/sadas@2x.png',
                  'assets/photos/sad.png',
                ];
                return Padding(
                  padding: EdgeInsets.only(
                    left: i == 0 ? 24 : 12,
                    right: i == 8 ? 24 : 12,
                  ),
                  child: _lessonCard(
                    context,
                    title: i.isEven ? 'Figma master class' : 'UX design basics',
                    subtitle: i.isEven
                        ? 'UI design  (5 lessons)'
                        : 'UX design  (5 lessons)',
                    imagePath: images[i],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _banner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF061A3A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 8, top: 4, bottom: 4),
            child: const Text(
              'Discover Top Picks',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  padding: const EdgeInsets.only(left: 8, top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '+100 lessons',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      GestureDetector(
                        onTap: () => Navigator.pushNamed(context, AppRoutes.courseOverview),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          decoration: BoxDecoration(
                            color: const Color(0xFFD4EEF7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Explore more',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 1,
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: AssetImage('assets/photos/Pngtree.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _lessonCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required String imagePath,
  }) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, AppRoutes.tasksDetail),
        child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 110,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: AssetImage(imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
            Text(subtitle, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Chip(icon: Icons.access_time, text: '2h 30min', color: Color(0xFFE8DEFF)),
                Row(
                  children: const [
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    SizedBox(width: 4),
                    Text('4.9'),
                  ],
                ),
              ],
            ),
          ],
        ),
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  final IconData? icon;
  final String text;
  final Color? color;
  const _Chip({this.icon, required this.text, this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minWidth: 0,
        maxWidth: 160,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color ?? const Color(0xFFD4EEF7),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) Icon(icon, size: 16),
          if (icon != null) const SizedBox(width: 6),
          Flexible(child: Text(text, overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}
