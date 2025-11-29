import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../data/dummy_data.dart';

class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _pageController,
        scrollDirection: Axis.vertical,
        itemCount: dummyReels.length,
        itemBuilder: (context, index) {
          final reel = dummyReels[index];
          return ReelItem(reel: reel);
        },
      ),
    );
  }
}

class ReelItem extends StatelessWidget {
  const ReelItem({super.key, required this.reel});
  final Reel reel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Video placeholder (using image for now)
        CachedNetworkImage(
          imageUrl: reel.thumbnailUrl,
          fit: BoxFit.cover,
          placeholder: (c, s) => Container(color: Colors.grey[900]),
        ),
        // Overlay
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, const Color(0x80000000)],
            ),
          ),
        ),
        // Content
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User info
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(reel.user.avatarUrl),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    reel.user.displayName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  if (reel.user.isVerified) ...[
                    const SizedBox(width: 4),
                    const Icon(Icons.verified, color: Colors.blue, size: 16),
                  ],
                ],
              ),
              const SizedBox(height: 12),
              // Caption
              Text(
                reel.caption,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              // Actions
              Row(
                children: [
                  _actionButton(Icons.favorite_border, '${reel.likesCount}'),
                  const SizedBox(width: 20),
                  _actionButton(
                    Icons.chat_bubble_outline,
                    '${reel.commentsCount}',
                  ),
                  const SizedBox(width: 20),
                  _actionButton(Icons.share, ''),
                  const Spacer(),
                  // Music disc placeholder
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 2),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.music_note,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: Colors.white, size: 28),
        if (label.isNotEmpty) ...[
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
