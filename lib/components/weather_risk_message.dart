import 'package:flutter/material.dart';

class WeatherRiskComponent extends StatelessWidget {
  final String weatherCondition; // e.g., 'rainy', 'cloudy', 'sunny', 'snowy'
  final int riskFactor; // Risk factor from 1 to 4

  WeatherRiskComponent({required this.weatherCondition, required this.riskFactor});

  String getMessage() {
    String riskMessage;
    switch (riskFactor) {
      case 4:
        riskMessage = "High risk! Please be cautious.";
        break;
      case 3:
        riskMessage = "Moderate risk. Stay alert!";
        break;
      case 2:
        riskMessage = "Low risk. You're good to go!";
        break;
      case 1:
        riskMessage = "Very low risk. Perfect conditions!";
        break;
      default:
        riskMessage = "Unknown risk factor.";
    }

    String weatherMessage;
    switch (weatherCondition.toLowerCase()) {
      case 'rainy':
        weatherMessage = "Rainy today. Carry an umbrella.";
        break;
      case 'cloudy':
        weatherMessage = "Cloudy today. Weather might change.";
        break;
      case 'sunny':
        weatherMessage = "Sunny today. Great for outdoor activities.";
        break;
      case 'snowy':
        weatherMessage = "Snowy today. Dress warmly and be cautious.";
        break;
      default:
        weatherMessage = "Weather information unavailable.";
    }

    return "$weatherMessage $riskMessage";
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 20, 20, 20),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        getMessage(),
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black, // Set the color for all text
        ),
      ),
    );
  }
}
