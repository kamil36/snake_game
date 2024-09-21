package com.example.s_game

import android.media.AudioManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.s_game/volume_brightness"

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        MethodChannel(flutterEngine!!.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "increaseVolume" -> {
                    increaseVolume()
                    result.success("Volume Increased")
                }
                "decreaseVolume" -> {
                    decreaseVolume()
                    result.success("Volume Decreased")
                }
                "setVolume" -> {
                    val volume = call.argument<Double>("volume")?.toFloat() ?: 0f
                    setVolume(volume)
                    result.success("Volume set to $volume")
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun increaseVolume() {
        val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
        audioManager.adjustVolume(AudioManager.ADJUST_RAISE, AudioManager.FLAG_PLAY_SOUND)
    }

    private fun decreaseVolume() {
        val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
        audioManager.adjustVolume(AudioManager.ADJUST_LOWER, AudioManager.FLAG_PLAY_SOUND)
    }

    private fun setVolume(volume: Float) {
        val audioManager = getSystemService(AUDIO_SERVICE) as AudioManager
        val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        val newVolume = (volume * maxVolume).toInt()
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, newVolume, 0)
    }
}
