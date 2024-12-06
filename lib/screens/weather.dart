import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobilerush/components/chances_of_rain.dart';
import 'package:mobilerush/components/recommended_place.dart';
import 'package:mobilerush/components/snowflake_weather.dart';
import 'package:mobilerush/components/weather_risk_message.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  // Weather and location details
  String city = "Kathmandu";
  String country = "Nepal";
  String weatherCondition = "Rainy";
  String feelsLike = "42°C";
  String backgroundImage = "assets/images/rainy.jpg";
  double rainChance = 0.0;
  int riskFactor = 3;
  
  // Weather statistics
  double windSpeed = 27.0;
  double humidity = 35.0;
  double atmPressure = 760.0;
  double temperature = 40;

  // Recommended places

  // Rain chance data for bar graph
  List<double> rainChances = [20, 45, 60, 35, 50, 25, 15];
  List<Map<String, String>> recommendedPlaces = [
    {"name": "Janaki Mandir", "distance": "5 km", "description": "A historic and religious site in Janakpur."},
    {"name": "Dhanush Sagar", "distance": "3 km", "description": "A serene and holy pond located near the temple."},
    {"name": "Ram Mandir", "distance": "6 km", "description": "A temple dedicated to Lord Rama in Janakpur."},
    {"name": "Ganga Sagar", "distance": "4 km", "description": "A sacred pond located near the Janaki Mandir."}
  ];

  // Mapping weather conditions to background images
  final Map<String, String> weatherBackgrounds = {
    "Sunny": "assets/images/sunny.jpg",
    "Rainy": "assets/images/rainy.jpg",
    "Snow": "assets/images/snowy.jpg",
  };

  @override
  void initState() {
    super.initState();
    fetchWeatherAndPlaces();
  }

Future<void> fetchWeatherAndPlaces() async {
  try {
    // Fetch weather data
    final weatherResponse = await http.get(
        Uri.parse("https://mr-api-three.vercel.app/weather"));
    
    // Check if response is successful
    if (weatherResponse.statusCode == 200) {
      final weatherData = json.decode(weatherResponse.body);

      // Null-safe data extraction with default values
      setState(() {
        // Location data with fallback
        city = weatherData['location']?['city'] ?? 'Unknown City';

        // Weather data with fallback values
        weatherCondition = weatherData['weather']?['condition'] ?? 'Unknown';
        feelsLike = "${weatherData['weather']?['feels_like'] ?? 0}°C";
        
        // Ensure numeric values are converted safely
        rainChance = (weatherData['weather']?['precipitation_probability'] ?? 0.0).toDouble();
        windSpeed = (weatherData['weather']?['wind_speed'] ?? 0.0).toDouble();
        humidity = (weatherData['weather']?['humidity'] ?? 0.0).toDouble();
        atmPressure = (weatherData['weather']?['atm_pressure'] ?? 0.0).toDouble();
        temperature = (weatherData['weather']?['temperature'] ?? 0.0).toDouble();
        riskFactor = (weatherData['weather']?['risk_factor'] ?? 0);

        // Set dynamic background based on weather condition
        backgroundImage = weatherBackgrounds[weatherCondition] ?? 
                          "assets/images/rainy.jpg";
      });
    } else {
      // Handle unsuccessful response
      print('Failed to fetch weather data: ${weatherResponse.statusCode}');
      _setDefaultWeatherData();
    }
  } catch (e) {
    print("Error fetching weather and places data: $e");
    _setDefaultWeatherData();
  }
}

// Method to set default weather data in case of error
void _setDefaultWeatherData() {
  setState(() {
    city = "Kathmandu";
    country = "Nepal";
    weatherCondition = "Sunny";
    feelsLike = "30°C";
    rainChance = 0.0;
    windSpeed = 0.0;
    humidity = 0.0;
    atmPressure = 0.0;
    temperature = 30.0;
    backgroundImage = "assets/images/sunny.jpg";
  });
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.7), 
              BlendMode.lighten
            ),
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Improved Location Header
                _buildLocationHeader(),
                
                const SizedBox(height: 16),
                _buildWeatherHeader(),
                
                      
                // Weather Header Section
                
                const SizedBox(height: 16),
                _buildWeatherStatsCard(),
                
                const SizedBox(height: 16),

                Container(
                  padding: EdgeInsets.all(16),
                  child: 


                WeatherRiskComponent(weatherCondition: weatherCondition, riskFactor: riskFactor),
                ),
      
                // Rain Chances Section with Bar Graph
                Stack(
                  children: [
                    WinterWonderland(),


                // Recommended Places Section
                buildRecommendedPlacesSection(),
                  ],),
                
                const SizedBox(height: 32),
                buildRainChancesSection()
              ],
            ),
          ),
        ),
      ),
    );
  }

  // New Location Header with Improved UI
  Widget _buildLocationHeader() {
    //showing location in center with location icon
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.location_on_outlined, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          "$city, $country",
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }



  // Improved Weather Header
  Widget _buildWeatherHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${temperature.toInt()}°C",
            style: const TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 16),
          //line between temperature and weather condition
          Container(
            height: 80,
            width: 1.5,
            color: Colors.white.withOpacity(0.5),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                weatherCondition,
                style: const TextStyle(
                  fontSize: 28, 
                  color: Colors.white,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                "Feels Like $feelsLike",
                style: const TextStyle(
                  fontSize: 18, 
                  color: Colors.white70
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Professional Weather Stats Card
  Widget _buildWeatherStatsCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2), width: 1.5),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  children: [
    Column(
      children: [
        _buildWeatherStatWithIcon(
          "Precipitation", 
          "$rainChance%", 
          Icons.water_drop_outlined,
          Colors.blue.shade600
        ),
        const SizedBox(height: 16),
        _buildWeatherStatWithIcon(
          "Wind", 
          "$windSpeed km/hr", 
          Icons.air_outlined,
          Colors.green.shade600
        ),
      ],
    ),
    // Vertical divider
    Container(
      height: 120,
      width: 1,
      color: Colors.grey.shade300,
    ),
    Column(
      children: [
        _buildWeatherStatWithIcon(
          "Pressure", 
          "$atmPressure mm", 
          Icons.speed_outlined,
          Colors.purple.shade600
        ),
        const SizedBox(height: 16),
        _buildWeatherStatWithIcon(
          "Humidity", 
          "$humidity%", 
          Icons.cloud_outlined,
          Colors.orange.shade600
        ),
      ],
    ),
  ],
));
  }

  

  // Enhanced Weather Stat with Icon
  Widget _buildWeatherStatWithIcon(
    String label, 
    String value, 
    IconData icon, 
    Color iconColor
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Icon(icon,color:Colors.white,size: 30),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value, 
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ],
    );
  }


  String _getCurrentDate() {
    final now = DateTime.now();
    return "${now.day}-${now.month}-${now.year}";
  }

  // Recommended Places Section


}