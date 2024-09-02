import 'package:dojo/Screens/New%20Recording/new_recording.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
      padding: const EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        bottom:
            20.0, // Add bottom padding for the gap between the navbar and the bottom of the screen
        top: 8.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(
              0xFFFFF9F1), // Set the background color of the navigation bar
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
                  icon: Icon(PhosphorIcons.houseSimple()),
                  onPressed: () => _onItemTapped(0),
                  color: _selectedIndex.value == 0
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.magnifyingGlass()),
                  onPressed: () => _onItemTapped(1),
                  color: _selectedIndex.value == 1
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
                IconButton(
                  icon: Container(
                    height: 50.0,
                    width: 50.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFB26767),
                    ),
                  ),
                  onPressed: () async {
                    if (!isRecording.value) {
                      isRecording.value = true;
                      await audioRecorderService.startRecord();
                    } else {
                      isRecording.value = false;
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled:
                            true, // Allows the sheet to be taller
                        backgroundColor: Colors
                            .transparent, // Transparent background for floating effect
                        builder: (context) => NewRecording(),
                      );

                      await audioRecorderService.stopRecord();
                      isRecording.value = false;
                    }
                    _onItemTapped(2);
                  },
                  color: _selectedIndex.value == 2
                      ? Color(0xFFD95C5C)
                      : Color(0xFFD95C5C),
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.trophy()),
                  onPressed: () => _onItemTapped(3),
                  color: _selectedIndex.value == 3
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.gearSix()),
                  onPressed: () {
                    _onItemTapped(4);
                  },
                  color: _selectedIndex.value == 4
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
              ],
            ),
            // Commented out the play, pause, and stop buttons
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
            //   children: [
            //     IconButton(
            //       icon: Icon(Icons.play_arrow),
            //       onPressed: () async {
            //         await audioPlayerService.playAudio();
            //         print('Playing audio?');
            //       },
            //       color: Colors.green,
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.pause),
            //       onPressed: () {
            //         audioPlayerService.pauseAudio();
            //       },
            //       color: Colors.yellow,
            //     ),
            //     IconButton(
            //       icon: Icon(Icons.stop),
            //       onPressed: () {
            //         audioPlayerService.stopAudio();
            //       },
            //       color: Colors.red,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
