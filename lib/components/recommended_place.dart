import 'package:flutter/material.dart';
import 'package:mobilerush/config/services.dart';

Widget buildRecommendedPlacesSection() {
  return FutureBuilder<List<Map<String, String>>>(
    future: fetchRecommendedPlaces(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      }

      if (snapshot.hasError) {
        return const Center(child: Text('Error loading data'));
      }

      if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text('No places available'));
      }

      final recommendedPlaces = snapshot.data!;

      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recommended Places",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true, // Ensures the list view takes only the required space
              physics: const NeverScrollableScrollPhysics(), // Prevents nested scrolling
              itemCount: recommendedPlaces.length,
              itemBuilder: (context, index) {
                final place = recommendedPlaces[index];
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image section
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey.withOpacity(0.3),
                          image: DecorationImage(
                            image: AssetImage(place['imageUrl'] ?? 'assets/images/placeholder.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Details section
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              place['name']!,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              place['distance']!,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              place['description']!,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                              maxLines: 3, // Limit to 3 lines
                              overflow: TextOverflow.ellipsis, // Add ellipsis for overflow
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(), // Adds a separator between items
            ),
          ],
        ),
      );
    },
  );
}
