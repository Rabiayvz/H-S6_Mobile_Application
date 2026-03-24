class SearchTarget {
  const SearchTarget({
    required this.id,
    required this.label,
    required this.iconName,
  });

  final String id;
  final String label;
  final String iconName;

  factory SearchTarget.fromJson(Map<String, dynamic> json) {
    return SearchTarget(
      id: json['id'] as String? ?? '',
      label: json['label'] as String? ?? 'Hedef',
      iconName: json['icon'] as String? ?? 'search',
    );
  }
}
