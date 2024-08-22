// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class NewRecording extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            ),
            SizedBox(height: 50.0),
            ElevatedButton(
              onPressed: () {
                print('Recording saved');
              },
              child: Text('Save'),
            )
          ],
        ),
      ),
    );
  }
}
