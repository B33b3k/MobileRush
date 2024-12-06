import 'package:flutter/material.dart';
import 'package:snow_fall_animation/snow_fall_animation.dart';

class WinterWonderland extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned.fill( // Make sure it fills the entire screen
      child: Stack(
        children: [
          // Transparent Background for Winter Wonderland
          Container(
            color: Colors.transparent, // Fully transparent container
          ),

          // Snowfall Animation with Christmas Theme
          SnowFallAnimation(
            config: SnowfallConfig(
              cleanupDuration: const Duration(seconds: 2), // Longer cleanup duration
              numberOfSnowflakes: 10, // Reduced number of snowflakes
              speed: 1.0, // Slightly slower snowfall for a more natural effect
              useEmoji: true, // Enable emojis for snowflakes
              customEmojis: ['❄️', '🎄', '🎅', '🎁', '✨', '⭐'], // Christmas-themed emojis
              windForce: 0.8, // Gentle breeze
              enableRandomSize: true, // Random snowflake sizes
              enableRandomOpacity: true, // Random opacity
              minOpacity: 0.6,
              maxOpacity: 1.0,
              minSnowflakeSize: 6.0,
              maxSnowflakeSize: 12.0, // Slightly smaller snowflakes
              enableSnowDrift: true, // Enable horizontal drifting
              // Custom behavior for snowflakes disappearing once they reach the ground
              
            
            ),
          ),
        ],
      ),
    );
  }
}
