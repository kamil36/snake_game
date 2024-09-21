import 'package:flutter/material.dart';
import 'package:s_game/game.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return const StarGame();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.network(
          'https://www.sellanycode.com/system/assets/uploads/products/FoodEatingSnakeGame_sellanycode_featured_image_1641658194.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
