class RegisteredObject {
  const RegisteredObject({
    required this.id,
    required this.name,
    required this.category,
    required this.imageUrl,
  });

  final String id;
  final String name;
  final String category;
  final String imageUrl;

  factory RegisteredObject.fromJson(Map<String, dynamic> json) {
    return RegisteredObject(
      id: json['id'] as String? ?? '',
      name: json['name'] as String? ?? 'Isimsiz Obje',
      category: json['category'] as String? ?? 'Diger',
      imageUrl:
          json['imageUrl'] as String? ??
          'https://picsum.photos/seed/defaultobject/600/400',
    );
  }
}
