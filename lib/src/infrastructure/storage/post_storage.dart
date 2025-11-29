import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/post.dart';

const _kSavedPosts = 'saved_posts_v1';

class PostStorage {
  static Future<List<Post>> loadPosts() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_kSavedPosts);
    if (raw == null) return [];
    return raw
        .map((s) => Post.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  static Future<void> savePosts(List<Post> posts) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = posts.map((p) => jsonEncode(p.toJson())).toList();
    await prefs.setStringList(_kSavedPosts, raw);
  }
}
