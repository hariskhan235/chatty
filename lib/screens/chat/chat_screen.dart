import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  final name;
  const ChatScreen({super.key,required this.name});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: const Center(
        child: Text('Start Chat'),
      ),
    );
  }
}