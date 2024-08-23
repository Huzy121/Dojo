// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dojo/assets/riverpod.dart';

class NewRecording extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingName = ref.watch(recordingTitleRiverpod);
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
              },
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
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
