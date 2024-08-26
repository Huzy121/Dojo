import 'dart:io';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Create a NotifierProvider for the RecordingListNotifier
final recordingListProvider =
    NotifierProvider<RecordingListNotifier, List<String>>(() {
  return RecordingListNotifier();
});

// Define the Notifier class
class RecordingListNotifier extends Notifier<List<String>> {
  // The build method is called when the provider is first created
  @override
  List<String> build() {
    // Fetch the path from the localDirectoryProvider
    final path = ref.read(localDirectoryProvider);

    // Create a Directory object using the fetched path
    final Directory directory = Directory(path);

    // List all files in the directory synchronously
    final List<FileSystemEntity> files = directory.listSync();
    print('thign: ${files.length}');
    List<String> fileNames = [];
    for (var file in files) {
      print('for loop check ${file.path}');
      if (file.path.split('/').last.toString()[0] == '.') {
        print('check ${file.path}');
        continue;
      } else {
        print('adding ${file.path}');
        fileNames.add(file.path.split('/').last);
      }
    }

    // Return the list of files to initialize the state
    return fileNames;
  }

  // Optional: A method to refresh the list of files, if needed
  void refreshFiles() {
    final path = ref.read(localDirectoryProvider);
    final Directory directory = Directory(path);
    state = directory.listSync().map(
      (e) {
        return e.path.split('/').last;
      },
    ).toList();
  }

  void addAudio(String audioName) {
    print(audioName);
    state = [...state, audioName];
    print('mystate: ${state}');
  }

  void mockLoadFiles() {
    List<String> medicalConditions = [
      'Pulmonary Embolism',
      'Myocardial Infarction',
      'Pleural Effusion',
      'Chronic Obstructive Pulmonary Disease',
      'Acute Respiratory Distress Syndrome',
      'Congestive Heart Failure',
      'Diabetes Mellitus',
      'Coronary Artery Disease',
    ];
    state = [];
    //state = [...medicalConditions];
  }
}
