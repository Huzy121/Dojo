// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:dojo/assets/files_notifier.dart';

class NewRecording extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: double.infinity,
      height: 500,
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Recording Title: '),
            SizedBox(height: 20.0),
            TextField(
              autofocus: true,
              onChanged: (newText) {
                ref.read(recordingTitleRiverpod.notifier).state = newText;
                print('new text: ${ref.read(recordingTitleRiverpod)}');
              },
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () async {
                ref
                    .read(recordingListProvider.notifier)
                    .addAudio(ref.read(recordingTitleRiverpod.notifier).state);
                await ref.read(audioRecorderServiceProvider).renameAudio(ref);
                print(
                    'this: ${ref.read(recordingTitleRiverpod.notifier).state}');
                Navigator.pop(context, ref);
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
