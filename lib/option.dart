import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class OptionPage extends StatelessWidget {
  static const platform = MethodChannel('com.example.s_game/volume_brightness');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
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
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 100,
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 200),
                  backgroundColor: Colors.black,
                  shape: CircleBorder(),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  _decreaseVolume();
                },
                child: Icon(
                  Icons.remove,
                  color: Colors.white,
                  size: 100,
                ),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(200, 200),
                  backgroundColor: Colors.black,
                  shape: CircleBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _increaseVolume() async {
    try {
      await platform.invokeMethod('increaseVolume');
    } on PlatformException catch (e) {
      print("Failed to increase volume: '${e.message}'.");
    }
  }

  Future<void> _decreaseVolume() async {
    try {
      await platform.invokeMethod('decreaseVolume');
    } on PlatformException catch (e) {
      print("Failed to decrease volume: '${e.message}'.");
    }
  }
}
