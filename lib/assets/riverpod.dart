// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/Services/audio_recorder_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final pageViewControllerProvider = Provider<PageController>((ref) {
  return PageController(viewportFraction: 0.92);
});

final volumeProvider = StateProvider<double>((ref) {
  return 0.5;
});

final isPlayingProvider = StateProvider<bool>((ref) {
  return false;
});

final audioPlayerServiceProvider = StateProvider<AudioPlayerService>((ref) {
  return AudioPlayerService();
});

final audioDurationProvider = StateProvider<Duration>((ref) {
  return Duration();
});

final positionProvider = StreamProvider.autoDispose<Duration>((ref) {
  final audioPlayerService = ref.watch(audioPlayerServiceProvider);

  return audioPlayerService.onPositionChanged;
});

final currentlyPlayingProvider = StateProvider<String>((ref) {
  return '';
});

final audioRecorderServiceProvider = StateProvider<AudioRecorderService>((ref) {
  return AudioRecorderService();
});

final localDirectoryProvider = Provider<String>((ref) {
  // throw UnimplementedError();
  return '';
});

final recordingTitleProvider = StateProvider<String>((ref) {
  return '';
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
