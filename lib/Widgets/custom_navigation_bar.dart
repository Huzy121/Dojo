// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:dojo/Screens/new_recording.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/Services/audio_recorder_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:audioplayers/audioplayers.dart';
import 'dart:io' as io;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class CustomNavigationBar extends StatefulWidget {
  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  bool isRecording = false;
  int _selectedIndex = 0;
  AudioRecorderService audioRecorderService = AudioRecorderService();
  AudioPlayerService audioPlayerService = AudioPlayerService();
  AudioPlayer audioPlayer = AudioPlayer();
  io.Directory? audioFilePath;

  @override
  void initState() {
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
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
                onPressed: () async {
                  if (!isRecording) {
                    print('Starting your recording now!');
                    setState(() {
                      isRecording = true;
                    });
                    await audioRecorderService.startRecord();
                  } else {
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) => NewRecording(),
                    );
                    print('Stopping your recording now!');
                    await audioRecorderService.stopRecord();
                    setState(() {
                      isRecording = false;
                    });
                  }
                  _onItemTapped(2);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.play_arrow),
                onPressed: () async {
                  await audioPlayerService.playAudio();
                  print('Playing audio?');
                },
                color: Colors.green,
              ),
              IconButton(
                icon: Icon(Icons.pause),
                onPressed: () {
                  audioPlayerService.pauseAudio();
                },
                color: Colors.yellow,
              ),
              IconButton(
                icon: Icon(Icons.stop),
                onPressed: () {
                  audioPlayerService.stopAudio();
                },
                color: Colors.red,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
