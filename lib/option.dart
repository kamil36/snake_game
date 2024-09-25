import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptionPage extends StatefulWidget {
  const OptionPage({super.key});

  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  static const platform = MethodChannel('com.example.s_game/volume_brightness');

  double _currentVolume = 0.5; // Initial volume (50%)

  @override
  void initState() {
    super.initState();
    _getCurrentVolume(); // Get the initial volume when the screen loads
  }

  // Method to get the current volume from the native platform
  Future<void> _getCurrentVolume() async {
    try {
      final double volume = await platform.invokeMethod('getCurrentVolume');
      setState(() {
        _currentVolume = volume;
      });
    } on PlatformException catch (e) {
      print("Failed to get current volume: '${e.message}'.");
    }
  }

  // Method to increase the volume via the native platform
  Future<void> _increaseVolume() async {
    try {
      await platform.invokeMethod('increaseVolume');
      _getCurrentVolume(); // Update the volume bar
    } on PlatformException catch (e) {
      print("Failed to increase volume: '${e.message}'.");
    }
  }

  // Method to decrease the volume via the native platform
  Future<void> _decreaseVolume() async {
    try {
      await platform.invokeMethod('decreaseVolume');
      _getCurrentVolume(); // Update the volume bar
    } on PlatformException catch (e) {
      print("Failed to decrease volume: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Volume Control",
            style: TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  _increaseVolume();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 200),
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.volume_up_outlined,
                      color: Colors.white,
                      size: 90,
                    ),
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 60,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              // Volume Bar (Slider)
              Text(
                'Volume: ${(_currentVolume * 100).round()}%',
                style: const TextStyle(fontSize: 20),
              ),
              Slider(
                value: _currentVolume,
                min: 0,
                max: 1,
                divisions: 10,
                label: "${(_currentVolume * 100).round()}",
                onChanged: (double value) {
                  setState(() {
                    _currentVolume = value;
                  });
                },
              ),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                onPressed: () {
                  _decreaseVolume();
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(200, 200),
                  backgroundColor: Colors.black,
                  shape: const CircleBorder(),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.volume_down,
                      color: Colors.white,
                      size: 90,
                    ),
                    Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 60,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
