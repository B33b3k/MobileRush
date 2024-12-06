import 'dart:convert';
import 'package:flutter/services.dart';

Future<List<Map<String, String>>> fetchRecommendedPlaces() async {
  // Load the JSON file from assets
  final String response = await rootBundle.loadString('assets/data/places.json');
  
  // Decode the JSON string
  final List<dynamic> data = json.decode(response);
  
  // Convert each element to a map and return it
  return data.map<Map<String, String>>((place) {
    return {
      'name': place['name'] ?? '',
      'distance': place['distance'] ?? '',
      'description': place['description'] ?? '',
      'imageUrl': place['imageUrl'] ?? '',
    };
  }).toList();
}
