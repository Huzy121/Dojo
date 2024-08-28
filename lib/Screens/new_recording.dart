// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:dojo/assets/files_notifier.dart';

class NewRecording extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 40.0, // Padding to make it look detached from the bottom
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4), // Downward shadow for floating effect
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the modal
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 400,
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
                        ref.read(recordingTitleProvider.notifier).state = ref
                            .read(audioRecorderServiceProvider)
                            .capitalizeEachWord(newText);
                        print('new text: ${ref.read(recordingTitleProvider)}');
                      },
                    ),
                    SizedBox(height: 50.0),
                    ElevatedButton(
                      onPressed: () async {
                        await ref
                            .read(audioRecorderServiceProvider)
                            .renameAudio(ref);
                        Navigator.pop(context, ref);
                      },
                      child: Text('Save'),
                    )
                  ],
                ),
              ),
            ), // Your NewRecording widget
          ),
        ),
      ),
    );
  }
}
