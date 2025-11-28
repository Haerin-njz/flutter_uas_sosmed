import 'dart:async';
import 'package:flutter/material.dart';
import '../../../features/stories/data/story_model.dart';

class StoryViewer extends StatefulWidget {
  final Story story;
  final VoidCallback onComplete;

  const StoryViewer({
    super.key,
    required this.story,
    required this.onComplete,
  });

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    _loadStory(0);
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  void _loadStory(int index) {
    _animController.stop();
    _animController.reset();
    _animController.duration = const Duration(seconds: 5); // Durasi per slide
    _animController.forward().whenComplete(_nextStory);
  }

  void _nextStory() {
    if (_currentIndex < widget.story.mediaUrls.length - 1) {
      setState(() {
        _currentIndex++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _loadStory(_currentIndex);
    } else {
      widget.onComplete(); // Panggil callback jika story habis
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _loadStory(_currentIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaList = widget.story.mediaUrls;

    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapUp: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.globalPosition.dx < width / 3) {
            _previousStory();
          } else {
            _nextStory();
          }
        },
        child: Stack(
          children: [
            // Konten Story (Gambar)
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(), // Disable swipe manual agar ikut timer/tap
              itemCount: mediaList.length,
              itemBuilder: (context, index) {
                return Image.network(
                  mediaList[index],
                  fit: BoxFit.contain,
                  loadingBuilder: (ctx, child, progress) {
                    if (progress == null) return child;
                    return const Center(child: CircularProgressIndicator());
                  },
                  errorBuilder: (ctx, _, __) => const Center(
                    child: Text('Error loading image', style: TextStyle(color: Colors.white)),
                  ),
                );
              },
            ),

            // Bar Progress di Atas
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: List.generate(mediaList.length, (index) {
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: LinearProgressIndicator(
                        value: index < _currentIndex
                            ? 1.0
                            : index == _currentIndex
                                ? _animController.value
                                : 0.0,
                        backgroundColor: Colors.white24,
                        valueColor: const AlwaysStoppedAnimation(Colors.white),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Info User (Avatar & Nama)
            Positioned(
              top: 55,
              left: 16,
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(widget.story.userAvatar ?? ''),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.story.userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
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
}