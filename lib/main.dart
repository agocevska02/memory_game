import 'package:flutter/material.dart';
import 'package:memory_game/screens/level_selection_screen.dart';
import 'package:memory_game/screens/memory_game_screen.dart';

void main() {
  runApp(MemoryGameApp());
}

class MemoryGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToLevelSelection();
  }

  void _navigateToLevelSelection() {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LevelSelectionScreen(
            onLevelSelected: (level) {
              int gridSize = 4;
              if (level == 'Medium') gridSize = 6;
              if (level == 'Hard') gridSize = 8;

              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MemoryGameScreen(gridSize: gridSize),
                ),
              );
            },
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.memory, size: 100, color: Colors.white),
            SizedBox(height: 20),
            Text(
              'Memory Game',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
