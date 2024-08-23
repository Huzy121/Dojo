import 'package:flutter_riverpod/flutter_riverpod.dart';

final recordingTitleRiverpod = StateProvider<String>((ref) {
  return 'NewRecording.m4a';
});
final isRecordingProvider = StateProvider<bool>((ref) {
  return false;
});
