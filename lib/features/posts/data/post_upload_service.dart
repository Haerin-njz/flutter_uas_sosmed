import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PostUploadService {
  static Future<String> uploadMedia(File file) async {
    final id = const Uuid().v4();
    final ref = FirebaseStorage.instance.ref().child("posts/$id");

    final uploadTask = await ref.putFile(file);
    return await ref.getDownloadURL();
  }
}
