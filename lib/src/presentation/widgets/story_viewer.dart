import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/story.dart';

class StoryViewer extends StatefulWidget {
  const StoryViewer({super.key, required this.story, this.onComplete});
  final Story story;
  final VoidCallback? onComplete;

  @override
  State<StoryViewer> createState() => _StoryViewerState();
}

class _StoryViewerState extends State<StoryViewer> {
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), _next);
  }

  void _next() {
    if (_index < widget.story.mediaUrls.length - 1) {
      setState(() => _index++);
      _startTimer();
    } else {
      widget.onComplete?.call();
    }
  }

  void _prev() {
    if (_index > 0) {
      setState(() => _index--);
      _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final url = widget.story.mediaUrls[_index];
    return GestureDetector(
      onTapUp: (details) {
        final w = MediaQuery.of(context).size.width;
        if (details.globalPosition.dx < w / 3) {
          _prev();
        } else if (details.globalPosition.dx > 2 * w / 3) {
          _next();
        } else {
          // tap center to pause/resume
          if (_timer?.isActive ?? false) {
            _timer?.cancel();
          } else {
            _startTimer();
          }
        }
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            placeholder: (c, s) => Container(color: Colors.black12),
            errorWidget: (c, s, e) => const Center(child: Icon(Icons.error)),
          ),
          Positioned(
            top: 32,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: List.generate(widget.story.mediaUrls.length, (i) {
                    final progress = i < _index ? 1.0 : (i == _index ? 0.5 : 0.0);
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 2),
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha((0.8 * progress * 255).clamp(0, 255).toInt()),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    CircleAvatar(radius: 18, backgroundImage: widget.story.userAvatar != null ? NetworkImage(widget.story.userAvatar!) : null),
                    const SizedBox(width: 8),
                    Text(widget.story.userName, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
