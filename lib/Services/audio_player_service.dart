import 'package:audioplayers/audioplayers.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class AudioPlayerService {
  AudioPlayer audioPlayer = AudioPlayer();
  io.Directory? audioFilePath;

  // Correct constructor
  AudioPlayerService() {
    _initialize();
  }

  Future<void> _initialize() async {
    audioFilePath = await getExternalStorageDirectory();
    print('aps path $audioFilePath');
  }

  Future<void> playAudio() async {
    try {
      // Wait for initialization if it's not completed yet
      if (audioFilePath == null) {
        await _initialize();
      }

      if (audioFilePath != null) {
        String filePath = '${audioFilePath!.path}/newrecording123456.m4a';
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
}
