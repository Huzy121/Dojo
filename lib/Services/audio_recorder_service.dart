import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io' as io;

class AudioRecorderService {
  late bool isRecording = false;
  late io.Directory? appDocDirectory;
  AudioRecorder audioRecorder = AudioRecorder();
  late AudioPlayer audioPlayer;
  String? audioFilePath;
  bool permissionResult = false;

  AudioRecorderService() {
    _initialize();
  }

  Future<void> _initialize() async {
    audioPlayer = AudioPlayer();
    await _requestMicrophonePermission();
    await _setAppDocDirectory();
    await _loadAudioFile();
  }

  Future<void> _setAppDocDirectory() async {
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }
  }

  Future<bool> checkMicPermission() async {
    permissionResult = await audioRecorder.hasPermission();
    print('Permission result is $permissionResult');
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }
    return permissionResult;
  }

  Future startRecord() async {
    await checkMicPermission();
    if (permissionResult == true) {
      print('Recording status: $permissionResult');
      print('Recording pressed.');
      await audioRecorder.start(
        const RecordConfig(),
        path: '${appDocDirectory!.path}/newrecording12345.m4a',
      );

      isRecording = await audioRecorder.isRecording();
    } else {
      print('Permission Fail (result print below)');
      print('perm result: $permissionResult');
    }
  }

  Future<void> _requestMicrophonePermission() async {
    PermissionStatus status = await Permission.microphone.status;

    if (!status.isGranted) {
      status = await Permission.microphone.request();
    }

    if (status.isGranted) {
      // Permission granted, proceed with your microphone-related functionality
    } else if (status.isDenied) {
      // Permission denied, show a message to the user
    } else if (status.isPermanentlyDenied) {
      // Permission permanently denied, take the user to settings
      openAppSettings();
    }
  }

  Future<void> _loadAudioFile() async {
    audioFilePath = '${appDocDirectory!.path}/newrecording123456.m4a';
  }

  Future stopRecord() async {
    await audioRecorder.stop();
    isRecording = await audioRecorder.isRecording();
    print('Path is: ${appDocDirectory!.path}');
    print('Recording stopped');
    print('Status of recording:  $isRecording');
  }

  io.Directory getPath() {
    return appDocDirectory!;
  }
}
