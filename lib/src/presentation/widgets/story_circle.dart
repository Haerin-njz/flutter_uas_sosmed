import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../domain/entities/story.dart';

class StoryCircle extends StatelessWidget {
  const StoryCircle({
    super.key,
    required this.story,
    this.onTap,
    this.size = 64.0,
  });

  final Story story;
  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        width: size,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: story.isViewed
                        ? null
                        : const LinearGradient(
                            colors: [Colors.purple, Colors.orange, Colors.red],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                  ),
                  padding: story.isViewed ? null : const EdgeInsets.all(3),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: story.isViewed
                          ? Border.all(color: Colors.grey.shade300, width: 2)
                          : null,
                    ),
                    child: ClipOval(
                      child: Builder(builder: (context) {
                        final avatar = story.userAvatar ?? '';
                        if (avatar.isNotEmpty && avatar.startsWith('http')) {
                          return CachedNetworkImage(
                            imageUrl: avatar,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                            errorWidget: (context, url, error) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                          );
                        }

                        if (avatar.isNotEmpty) {
                          return Image.asset(
                            avatar,
                            fit: BoxFit.cover,
                            width: size,
                            height: size,
                            errorBuilder: (context, error, stackTrace) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                          );
                        }

                        return Container(
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.person, color: Colors.grey),
                        );
                      }),
                    ),
                  ),
                ),
                if (!story.isViewed)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 14),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            // Username Instagram-style (no background, thin font)
            Container(
              width: size,
              alignment: Alignment.center,
              child: Text(
                story.userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
