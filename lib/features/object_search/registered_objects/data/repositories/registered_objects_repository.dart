import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/registered_object.dart';

class RegisteredObjectsRepository {
  const RegisteredObjectsRepository();

  Future<List<RegisteredObject>> getRegisteredObjects() async {
    final rawJson = await rootBundle.loadString(
      'assets/data/registered_objects.json',
    );
    final decoded = jsonDecode(rawJson) as Map<String, dynamic>;
    final objects = decoded['objects'] as List<dynamic>? ?? [];

    return objects
        .map((item) => RegisteredObject.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}
