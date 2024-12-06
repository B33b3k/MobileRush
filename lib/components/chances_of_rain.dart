import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget buildRainChancesSection() {
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
        const Text(
          "Chances of Rain (Hourly)",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 200,
          child: BarChart(
            BarChartData(
              barGroups: _createRainBarGroups(),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      // Map index to hours
                      const hours = ['6AM', '9AM', '12PM', '3PM', '6PM', '9PM', '12AM'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          hours[value.toInt()],
                          style: const TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      );
                    },
                    reservedSize: 30,
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text(
                        "${value.toInt()}%",
                        style: const TextStyle(color: Colors.black, fontSize: 10),
                      );
                    },
                    reservedSize: 40,
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 10,
                getDrawingHorizontalLine: (value) {
                  return FlLine(
                    color: Colors.white.withOpacity(0.1),
                    strokeWidth: 1,
                  );
                },
              ),
              maxY: 100, // Y-axis max value for percentages
            ),
          ),
        ),
      ],
    ),
  );
}

// Hourly rain chances data
final List<double> rainChances = [10.0, 20.0, 40.0, 60.0, 80.0, 30.0, 50.0];

// Set blue for the bar color
Color _getBarColor(double rainChance) {
  return Colors.blue; // All bars will be blue
}

// Generate bar groups
List<BarChartGroupData> _createRainBarGroups() {
  return List.generate(
    rainChances.length,
    (index) => BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(
          toY: rainChances[index],
          color: _getBarColor(rainChances[index]),
          width: 15,
          borderRadius: BorderRadius.circular(4),
        )
      ],
    ),
  );
}
