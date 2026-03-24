import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/video_call_contact.dart';

class VideoCallContactsRepository {
  const VideoCallContactsRepository();

  Future<List<VideoCallContact>> getContacts() async {
    final rawJson = await rootBundle.loadString(
      'assets/data/video_call_contacts.json',
    );
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    final contacts = decoded['contacts'] as List<dynamic>? ?? [];

    return contacts
        .map((item) => VideoCallContact.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
