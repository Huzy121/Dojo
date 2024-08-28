import 'package:audioplayers/audioplayers.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class AudioPlayerService {
  AudioPlayer audioPlayer = AudioPlayer();
  io.Directory? audioFilePath;
  Stream<Duration> get onPositionChanged => audioPlayer.onPositionChanged;
  // Correct constructor
  AudioPlayerService() {
    _initialize();
  }

  Future<void> _initialize() async {
    audioFilePath = await getExternalStorageDirectory();
    print('aps path $audioFilePath');
  }

  Future<void> playAudio(WidgetRef ref) async {
    final audioFile = ref.watch(currentlyPlayingProvider);
    try {
      // Wait for initialization if it's not completed yet
      if (audioFilePath == null) {
        await _initialize();
      }

      if (audioFilePath != null) {
        String filePath = '${audioFilePath!.path}/$audioFile.m4a';
        bool exists = await io.File(filePath).exists();
        if (exists) {
          print('Starting audio playback from $filePath');
          await audioPlayer.setSource(DeviceFileSource(filePath));
          await audioPlayer.resume();
          print('Audio playback finished');
        } else {
          print('Error: Audio file does not exist at $filePath');
        }
      } else {
        print('Error: audioFilePath is null');
      }
    } catch (e) {
      print('Error playing audio: $e');
    }
  }

  Future<void> pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> stopAudio() async {
    await audioPlayer.stop();
  }

  Future<void> seekTo(Duration position) async {
    await audioPlayer.seek(position);
  }

  Future<Duration?> getDuration(WidgetRef ref) async {
    final audioFile = ref.watch(currentlyPlayingProvider);
    String filePath = '${audioFilePath!.path}/$audioFile.m4a';
    await audioPlayer.setSource(DeviceFileSource(filePath));
    return await audioPlayer.getDuration();
  }
}
