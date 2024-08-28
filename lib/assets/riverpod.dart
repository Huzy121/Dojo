import 'dart:io';
import 'package:dojo/Services/audio_recorder_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final currentlyPlayingProvider = StateProvider<String>((ref) {
  return '';
});

final audioRecorderServiceProvider = Provider<AudioRecorderService>((ref) {
  return new AudioRecorderService();
});

final localDirectoryProvider = Provider<String>((ref) {
  // throw UnimplementedError();
  return '';
});

final recordingTitleProvider = StateProvider<String>((ref) {
  return 'NewRecording.m4a';
});

final isRecordingProvider = StateProvider<bool>((ref) {
  return false;
});
final recordingListFutureProvider =
    FutureProvider<List<FileSystemEntity>>((ref) async {
  String path = ref.read(localDirectoryProvider);

  Directory? directory = Directory(path);

  // List all files in the directory
  final List<FileSystemEntity> files = directory.listSync();
  print(files.toString());

  return files;
});
