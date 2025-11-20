import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../theme/app_palette.dart';

class LessonsScreen extends StatelessWidget {
  const LessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            const _SectionTitle(prefixBold: 'Lessons of ', bold: 'UI'),
            const SizedBox(height: 12),
   // --- Figma Lessons ---
          ..._items([
  _LessonItem('1st Lesson: Introduction to Figma', 'https://www.youtube.com/watch?v=jk1T0CdLxwU&t=43s'), // полный курс Figma для начинающих :contentReference[oaicite:0]{index=0}
  _LessonItem('2nd Lesson: Shapes, Frames & Layers', 'https://www.youtube.com/watch?v=FpFYdh2ccT0'), // рамки, слои, группы :contentReference[oaicite:1]{index=1}
  _LessonItem('3rd Lesson: Text & Typography in Figma', 'https://www.youtube.com/watch?v=ue0hKThvdgA'), // работа с формами / базовые фигуры (видео охватывает формы) :contentReference[oaicite:2]{index=2}
  _LessonItem('4th Lesson: Working with Colors & Styles', 'https://www.youtube.com/watch?v=8kHYLQnXnQc'), // твоё видео, оставлю (если найдём лучше — подменим)
  _LessonItem('5th Lesson: Components & Variants', 'https://www.youtube.com/watch?v=4g1gKkTrLCE'), // твоё видео, оставлю (но лучше дополнить позже)
]),

const SizedBox(height: 44),

// --- UX Lessons ---
const _SectionTitle(prefixBold: 'Lessons of ', bold: 'UX'),
const SizedBox(height: 12),
..._items([
  _LessonItem('1st Lesson: Introduction to UX', 'https://www.youtube.com/watch?v=Ovj4hFxko14'), // если найдём лучше — можем заменить
  _LessonItem('2nd Lesson: Understanding Users', 'https://www.youtube.com/watch?v=UrBM9SAUXC4'),
  _LessonItem('3rd Lesson: Wireframing Basics', 'https://www.youtube.com/watch?v=9ZPd-GJ6xk0'),
  _LessonItem('4th Lesson: Information Architecture', 'https://www.youtube.com/watch?v=6YkFyGJfOB8'),
  _LessonItem('5th Lesson: UX Writing & Microcopy', 'https://www.youtube.com/watch?v=TOTsxwquAN0'), // UX Writing Explained :contentReference[oaicite:3]{index=3}
]),
            const SizedBox(height: 44), // было 32, стало 44
            const Text(
              'Description:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            const Text(
              'This course is a voice-guided journey into UX/UI design, crafted for those who learn best through listening. Lessons are short and focused.',
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _items(List<_LessonItem> lessons) {
    return lessons
        .map(
          (lesson) => Padding(
            padding: const EdgeInsets.only(bottom: 28),
            child: _LessonRow(title: lesson.title, youtubeUrl: lesson.youtubeUrl),
          ),
        )
        .toList();
  }
}

class _LessonItem {
  final String title;
  final String youtubeUrl;

  const _LessonItem(this.title, this.youtubeUrl);
}

class _SectionTitle extends StatelessWidget {
  final String prefixBold;
  final String bold;
  const _SectionTitle({required this.prefixBold, required this.bold});
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(
          context,
        ).style.copyWith(fontSize: 26, fontWeight: FontWeight.w800),
        children: [
          TextSpan(text: prefixBold),
          TextSpan(
            text: bold,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
        ],
      ),
    );
  }
}

class _LessonRow extends StatefulWidget {
  final String title;
  final String youtubeUrl;
  const _LessonRow({required this.title, required this.youtubeUrl});
  @override
  State<_LessonRow> createState() => _LessonRowState();
}

class _LessonRowState extends State<_LessonRow> {
  bool _expanded = false;
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(widget.youtubeUrl)!,
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        hideControls: false,
        showLiveFullscreenButton: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: _expanded
            ? [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ]
            : [],
      ),
      child: InkWell(
        onTap: _toggleExpand,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppPalette.chipBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(child: Text(widget.title)),
                Icon(_expanded ? Icons.expand_less : Icons.expand_more),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _expanded
                  ? Column(
                      children: [
                        const SizedBox(height: 16),
                        Container(
                          height: 250,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: YoutubePlayer(
                            controller: _controller,
                            showVideoProgressIndicator: true,
                            progressIndicatorColor: AppPalette.purple,
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
