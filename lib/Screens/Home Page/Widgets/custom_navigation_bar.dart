// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, avoid_print

import 'package:dojo/Screens/New%20Recording/new_recording.dart';
import 'package:dojo/Screens/Search/search_page.dart';
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
    final _selectedIndex =
        ref.watch(navbarIndexProvider); // Use useState for managing state
    final audioRecorderService = ref.read(audioRecorderServiceProvider);
    AudioPlayerService audioPlayerService = AudioPlayerService();

    void _onItemTapped(int index) {
      ref.read(navbarIndexProvider.notifier).state =
          index; // Update the selectedIndex using useState
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
                  onPressed: () {
                    print(ref.read(pageViewControllerProvider.notifier).state);
                    ModalRoute.of(context)?.settings.name != '/'
                        ? Navigator.popUntil(
                            context,
                            // Replace '/home' with the route name of your Home page
                            (Route<dynamic> route) => route
                                .isFirst, // Remove all routes except the root route
                          )
                        : null;

                    _onItemTapped(0);
                  },
                  color: ref.read(navbarIndexProvider) == 0
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.magnifyingGlass()),
                  onPressed: () {
                    ModalRoute.of(context)?.settings.name != '/search'
                        ? Navigator.pushNamedAndRemoveUntil(
                            context,
                            '/search', // The route you're navigating to
                            (Route<dynamic> route) => route
                                .isFirst, // Remove all routes until the first route (the root '/')
                          )
                        : null;
                    _onItemTapped(1);
                  },
                  color: ref.read(navbarIndexProvider) == 1
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
                  },
                  color: ref.read(navbarIndexProvider) == 2
                      ? Color(0xFFD95C5C)
                      : Color(0xFFD95C5C),
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.trophy()),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                    _onItemTapped(3);
                  },
                  color: ref.read(navbarIndexProvider) == 3
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
                IconButton(
                  icon: Icon(PhosphorIcons.gearSix()),
                  onPressed: () {
                    _onItemTapped(4);
                  },
                  color: ref.read(navbarIndexProvider) == 4
                      ? Color(0xFFB3714A)
                      : Color(0xFFE2B893),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
