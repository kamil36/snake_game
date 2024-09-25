import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:s_game/game.dart';
import 'package:s_game/option.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff140F3D),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GameStartButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const StarGame();
                }));
              },
              bgColor: const Color(0xff2BC16A),
              textColor: const Color(0xffe3f1e7),
              buttonname: "Start",
            ),
            const SizedBox(
              height: 20,
            ),
            GameStartButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return OptionPage();
                }));
              },
              bgColor: const Color(0xffF8A942),
              textColor: const Color(0xffe3f1e7),
              buttonname: "Options",
            ),
            const SizedBox(
              height: 20,
            ),
            GameStartButton(
              onPressed: () {
                SystemNavigator.pop();
              },
              bgColor: const Color(0xffED573C),
              textColor: const Color(0xffe3f1e7),
              buttonname: "Exit",
            ),
          ],
        ),
      ),
    );
  }
}

class GameStartButton extends StatelessWidget {
  const GameStartButton({
    required this.bgColor,
    required this.textColor,
    required this.buttonname,
    required this.onPressed,
    super.key,
  });

  final Color? bgColor;
  final Color? textColor;
  final String buttonname;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100)),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: bgColor, fixedSize: const Size(300, 60)),
        child: Text(
          buttonname,
          style: TextStyle(color: textColor, fontSize: 40),
        ),
      ),
    );
  }
}


//package com.example.s_game

// import android.media.AudioManager
// import android.os.Bundle
// import io.flutter.embedding.android.FlutterActivity
// import io.flutter.plugin.common.MethodChannel

// class MainActivity : FlutterActivity() {
//     private val CHANNEL = "com.example.s_game/volume_brightness"

//     override fun onCreate(savedInstanceState: Bundle?) {
//         super.onCreate(savedInstanceState)

//         MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
//             when (call.method) {
//                 "increaseVolume" -> {
//                     increaseVolume()
//                     result.success("Volume Increased")
//                 }
//                 "decreaseVolume" -> {
//                     decreaseVolume()
//                     result.success("Volume Decreased")
//                 }
//                 "setVolume" -> {
//                     val volume = call.argument<Double>("volume")?.toFloat() ?: 0f
//                     setVolume(volume)
//                     result.success("Volume set to $volume")
//                 }
//                 else -> result.notImplemented()
//             }
//         }
//     }

//     private fun increaseVolume() {
//         val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
//         audioManager.adjustVolume(AudioManager.ADJUST_RAISE, AudioManager.FLAG_PLAY_SOUND)
//     }

//     private fun decreaseVolume() {
//         val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
//         audioManager.adjustVolume(AudioManager.ADJUST_LOWER, AudioManager.FLAG_PLAY_SOUND)
//     }

//     private fun setVolume(volume: Float) {
//         val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
//         val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
//         val newVolume = (volume * maxVolume).toInt()
//         audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, newVolume, 0)
//     }
// }
