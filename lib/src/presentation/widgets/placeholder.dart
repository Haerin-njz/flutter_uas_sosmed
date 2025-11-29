import 'package:flutter/material.dart';

class PlaceholderWidget extends StatelessWidget {
  const PlaceholderWidget({super.key, this.text});
  final String? text;

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(text ?? 'Placeholder'));
  }
}
