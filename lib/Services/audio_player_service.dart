import 'package:audioplayers/audioplayers.dart';
import 'dart:io' as io;

class AudioPlayerService {
  AudioPlayer audioPlayer = AudioPlayer();
  late io.Directory audioFilePath;
  AudioPlAudioPlayerService() {}
  Future<void> _playAudio() async {
    print('step 1: $audioFilePath');
    if (audioFilePath != null) {
      print('starting audio');
      await audioPlayer.setSource(
          DeviceFileSource('${audioFilePath.path}/newrecording1.m4a'));

      await audioPlayer.resume();
      print('audio finished');
    } else {
      print('error');
    }
  }

  Future<void> _pauseAudio() async {
    await audioPlayer.pause();
  }

  Future<void> _stopAudio() async {
    await audioPlayer.stop();
  }
}
