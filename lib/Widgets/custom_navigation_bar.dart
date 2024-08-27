import 'package:dojo/Screens/new_recording.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'dart:io' as io;
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomNavigationBar extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRecording = useState(false);
    final _selectedIndex = useState(0); // Use useState for managing state
    final audioRecorderService = ref.read(audioRecorderServiceProvider);
    AudioPlayerService audioPlayerService = AudioPlayerService();

    void _onItemTapped(int index) {
      _selectedIndex.value = index; // Update the selectedIndex using useState
    }

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 19.0), // Add horizontal padding for floating effect
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color of the navigation bar
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Slight shadow color
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4), // Slightly downward shadow
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
                  color: _selectedIndex.value == 0 ? Colors.blue : Colors.grey,
                ),
                IconButton(
                  icon: Icon(IonIcons.search),
                  onPressed: () => _onItemTapped(1),
                  color: _selectedIndex.value == 1 ? Colors.blue : Colors.grey,
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
                    if (!isRecording.value) {
                      isRecording.value = true;
                      await audioRecorderService.startRecord();
                    } else {
                      isRecording.value = false;
                      showModalBottomSheet(
                        isScrollControlled: true,
                        context: context,
                        builder: (context) => NewRecording(),
                      );

                      await audioRecorderService.stopRecord();
                      isRecording.value = false;
                    }
                    _onItemTapped(2);
                  },
                  color: _selectedIndex.value == 2 ? Colors.blue : Colors.red,
                ),
                IconButton(
                  icon: Icon(IonIcons.trophy),
                  onPressed: () => _onItemTapped(3),
                  color: _selectedIndex.value == 3 ? Colors.blue : Colors.grey,
                ),
                IconButton(
                  icon: Icon(IonIcons.settings),
                  onPressed: () => _onItemTapped(4),
                  color: _selectedIndex.value == 4 ? Colors.blue : Colors.grey,
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
      ),
    );
  }
}
