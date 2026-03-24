import 'package:flutter/material.dart';

import '../../data/models/video_call_contact.dart';

class MockVideoCallPage extends StatelessWidget {
  const MockVideoCallPage({super.key, required this.contact});

  final VideoCallContact contact;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(contact.name),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              contact.avatarUrl,
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.45),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 48,
                  backgroundImage: NetworkImage(contact.avatarUrl),
                ),
                const SizedBox(height: 14),
                Text(
                  '${contact.name} ile goruntulu arama',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Baglandi (onizleme)',
                  style: TextStyle(color: Color(0xFFBDBDBD)),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 30,
            child: Center(
              child: FloatingActionButton(
                onPressed: () => Navigator.pop(context),
                backgroundColor: const Color(0xFFC62828),
                child: const Icon(Icons.call_end),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
