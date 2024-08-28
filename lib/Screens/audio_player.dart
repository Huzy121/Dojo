// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AudioPlayer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0, // Padding to make it look detached from the bottom
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
              height: 220,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Audio Slider here'),
                    SizedBox(height: 25.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Previous'),
                        SizedBox(width: 15.0),
                        Text('Play'),
                        SizedBox(width: 15.0),
                        Text('Next'),
                      ],
                    ),
                    SizedBox(
                      height: 25.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Volume Icon'),
                        SizedBox(width: 15.0),
                        Text('Volume Slider'),
                      ],
                    ),
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
