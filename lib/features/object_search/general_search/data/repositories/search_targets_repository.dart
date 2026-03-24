import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/search_target.dart';

class SearchTargetsRepository {
  const SearchTargetsRepository();

  Future<List<SearchTarget>> getTargets() async {
    final rawJson = await rootBundle.loadString(
      'assets/data/general_search_targets.json',
    );
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    final targets = decoded['targets'] as List<dynamic>? ?? [];
    return targets
        .map((item) => SearchTarget.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
