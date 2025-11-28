import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  XFile? _media;

  Future pickMedia() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _media = picked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create Post")),
      body: Column(
        children: [
          const SizedBox(height: 20),
          
          _media == null
            ? const Text("No media selected")
            : Image.file(File(_media!.path), height: 300),

          const SizedBox(height: 20),

          ElevatedButton(
            onPressed: pickMedia,
            child: const Text("Choose Photo/Video"),
          ),

          ElevatedButton(
            onPressed: _media == null ? null : () {
              // Upload function
            },
            child: const Text("Upload"),
          )
        ],
      ),
    );
  }
}
