class VideoCallContact {
  const VideoCallContact({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.isOnline,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final bool isOnline;

  factory VideoCallContact.fromJson(Map<String, dynamic> json) {
    return VideoCallContact(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Isimsiz Kisi',
      avatarUrl:
          json['avatarUrl'] as String? ??
          'https://picsum.photos/seed/default-contact/400/400',
      isOnline: json['isOnline'] as bool? ?? false,
    );
  }
}
