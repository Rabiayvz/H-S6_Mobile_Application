import 'package:flutter/material.dart';

import '../../../../core/widgets/shared_bottom_bar.dart';
import '../../data/models/video_call_contact.dart';
import '../../data/repositories/video_call_contacts_repository.dart';
import 'mock_video_call_page.dart';

class VideoCallPage extends StatefulWidget {
  const VideoCallPage({super.key});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  static const _repository = VideoCallContactsRepository();

  late final Future<List<VideoCallContact>> _contactsFuture;

  @override
  void initState() {
    super.initState();
    _contactsFuture = _repository.getContacts();
  }

  void _openMockCall(VideoCallContact contact) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MockVideoCallPage(contact: contact),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text('Goruntulu Arama'),
      ),
      body: FutureBuilder<List<VideoCallContact>>(
        future: _contactsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Kisiler yuklenemedi.'));
          }

          final contacts = snapshot.data ?? [];
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 8),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: null,
                    icon: const Icon(Icons.contacts_outlined),
                    label: const Text('Rehberden Kisi Ekle (Yakinda)'),
                  ),
                ),
              ),
              Expanded(
                child:
                    contacts.isEmpty
                        ? const Center(child: Text('Kayitli kisi bulunamadi.'))
                        : ListView.separated(
                          padding: const EdgeInsets.all(16),
                          itemCount: contacts.length,
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final contact = contacts[index];
                            return Material(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(14),
                                onTap: () => _openMockCall(contact),
                                child: Ink(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    border: Border.all(
                                      color: const Color(0xFFE9E9E9),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: const Color(
                                          0xFFEDEDED,
                                        ),
                                        backgroundImage: NetworkImage(
                                          contact.avatarUrl,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              contact.name,
                                              style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              contact.isOnline
                                                  ? 'Musait'
                                                  : 'Musait degil',
                                              style: TextStyle(
                                                color:
                                                    contact.isOnline
                                                        ? const Color(
                                                          0xFF2E7D32,
                                                        )
                                                        : const Color(
                                                          0xFF757575,
                                                        ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Icon(Icons.videocam_outlined),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const SharedBottomBar(currentIndex: 3),
    );
  }
}
