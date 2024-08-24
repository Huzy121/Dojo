import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final recordingTitleRiverpod = StateProvider<String>((ref) {
  return 'NewRecording.m4a';
});
final isRecordingProvider = StateProvider<bool>((ref) {
  return false;
});
final recordingListFutureProvider =
    FutureProvider<List<FileSystemEntity>>((ref) async {
  Directory? directory;

  if (Platform.isAndroid) {
    // Use getExternalStorageDirectory for Android
    directory = await getExternalStorageDirectory();
  } else if (Platform.isIOS) {
    // Use getApplicationDocumentsDirectory for iOS
    directory = await getApplicationDocumentsDirectory();
  }

  // If directory is null, return an empty list
  if (directory == null) {
    print('Directory is null');
    return [];
  }

  // List all files in the directory
  final List<FileSystemEntity> files = directory.listSync();
  print(files.toString());

  return files;
});
