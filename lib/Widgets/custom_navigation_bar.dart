// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io' as io;

class CustomNavigationBar extends StatefulWidget {
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;
  bool permissionResult = false;
  late bool isRecording = false;
  late Directory? appDocDirectory;
  AudioRecorder audioRecorder = AudioRecorder();
  @override
  void initState() {
    super.initState();
    _requestMicrophonePermission();
  }

  Future<bool> checkMicPermission() async {
    permissionResult = await AudioRecorder().hasPermission();
    // permissions have been given + added into the .xml and .plist files
    print('permission result is $permissionResult');
    if (io.Platform.isIOS) {
      appDocDirectory = await getApplicationDocumentsDirectory();
      print(appDocDirectory.toString());
    } else {
      appDocDirectory = await getExternalStorageDirectory();
    }
    return permissionResult;
  }

  void startRecord() async {
    await checkMicPermission();
    if (permissionResult == true) {
      print('Recording status: $permissionResult');
      print('recording pressed.');
      await audioRecorder.start(
        const RecordConfig(),
        path: '${appDocDirectory!.path}/newrecording.m4a',
      );
      isRecording = await audioRecorder.isRecording();
    } else {
      print('Permission Fail (result print below');
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void stopRecord() async {
    await audioRecorder.stop();
    isRecording = await audioRecorder.isRecording();
    print('recording stopped');
    print(isRecording);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white, // Set the background color of the navigation bar
        boxShadow: [
          BoxShadow(
            color: Colors.transparent, // Set a transparent shadow
            spreadRadius: 0,
            blurRadius: 0,
            offset: Offset(0, 0), // Set the shadow offset
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            icon: Icon(IonIcons.home),
            onPressed: () => _onItemTapped(0),
            color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(IonIcons.search),
            onPressed: () => _onItemTapped(1),
            color: _selectedIndex == 1 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Container(
              height: 50.0,
              width: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              if (!isRecording) {
                print('STARTING');
                startRecord();
              } else {
                print('STOPPING');
                stopRecord();
              }

              () => _onItemTapped(2);
            },
            color: _selectedIndex == 2 ? Colors.blue : Colors.red,
          ),
          IconButton(
            icon: Icon(IonIcons.trophy),
            onPressed: () => _onItemTapped(3),
            color: _selectedIndex == 3 ? Colors.blue : Colors.grey,
          ),
          IconButton(
            icon: Icon(IonIcons.settings),
            onPressed: () => _onItemTapped(4),
            color: _selectedIndex == 4 ? Colors.blue : Colors.grey,
          ),
        ],
      ),
    );
  }
}
