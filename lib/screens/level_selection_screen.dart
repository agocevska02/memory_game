import 'package:flutter/material.dart';
import 'memory_game_screen.dart';

class LevelSelectionScreen extends StatelessWidget {
  final Function(String) onLevelSelected;

  LevelSelectionScreen({required this.onLevelSelected});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50], // Set a light background color
      appBar: AppBar(
        title: Text(
          'Memory Game',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align children to the top
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title text at the top with styling
            Text(
              'Choose Your Level Of Difficulty:',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
                letterSpacing: 1.0,
              ),

            ),
            SizedBox(height: 40), // Space between title and buttons

            // Easy Button with improved design
            _buildLevelButton(context, 'Easy', Colors.green, Icons.star_border),
            SizedBox(height: 20),

            // Medium Button with improved design
            _buildLevelButton(context, 'Medium', Colors.orange, Icons.star_half),
            SizedBox(height: 20),

            // Hard Button with improved design
            _buildLevelButton(context, 'Hard', Colors.red, Icons.star),
          ],
        ),
      ),
    );
  }

  // Custom button style for levels
  ElevatedButton _buildLevelButton(BuildContext context, String level, Color color, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () => onLevelSelected(level),
      icon: Icon(
        icon,
        color: Colors.white,
        size: 30,
      ),
      label: Text(
        level,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Background color based on level
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Rounded corners
        ),
        elevation: 5, // Button shadow
      ),
    );
  }
}
