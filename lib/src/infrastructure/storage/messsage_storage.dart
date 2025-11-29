import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/message.dart';

String _convKey(String id) => 'conv_${id}_v1';

class MessageStorage {
  static Future<List<Message>> loadMessages(String conversationId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_convKey(conversationId));
    if (raw == null) return [];
    return raw
        .map((s) => Message.fromJson(jsonDecode(s) as Map<String, dynamic>))
        .toList();
  }

  static Future<void> saveMessages(
    String conversationId,
    List<Message> messages,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = messages.map((m) => jsonEncode(m.toJson())).toList();
    await prefs.setStringList(_convKey(conversationId), raw);
  }

  static Future<void> clearConversation(String conversationId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_convKey(conversationId));
  }
}
