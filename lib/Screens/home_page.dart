// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:dojo/Screens/new_recording.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/Widgets/custom_navigation_bar.dart';
import 'package:dojo/assets/constants.dart';
import 'package:dojo/assets/files_notifier.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;
import 'audio_player.dart';

class HomePage extends StatefulHookConsumerWidget {
  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   Future.delayed(Duration(seconds: 2), () {
    //     ref.read(recordingListProvider.notifier).mockLoadFiles();
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    final recordingList = ref.watch(recordingListProvider);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning,',
                      style: kWelcomeText,
                    ),
                    Text(
                      'Huzaifah',
                      style: kWelcomeName,
                    ),
                  ],
                ),
                Image.asset(
                  'images/man.png',
                  width: 60.0,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              clipBehavior: Clip.none,
              controller: PageController(
                viewportFraction:
                    0.92, // Adjusted to show part of the next tile
              ),
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: recordingList.length,
              itemBuilder: (context, index) {
                final file = recordingList[index];
                final fileName = path.basename(file).replaceAll('.m4a', '');
                return Padding(
                  padding: const EdgeInsets.only(
                    top: 25.0,
                  ),
                  child: RecordingTile(title: fileName),
                );
              },
            ),
          ),
          SizedBox(
            height: 150.0,
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(), // Bottom navigation bar
    );
  }
}

class RecordingTile extends ConsumerWidget {
  final String title;
  const RecordingTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioPlayer = ref.watch(audioPlayerServiceProvider);
    return GestureDetector(
      onTap: () async {
        ref.read(audioPlayerServiceProvider.notifier).state =
            AudioPlayerService();
        ref.read(currentlyPlayingProvider.notifier).state = title;
        ref.read(audioDurationProvider.notifier).state =
            await audioPlayer.getDuration(ref) ?? Duration.zero;
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, // Allows the sheet to be taller
          backgroundColor:
              Colors.transparent, // Transparent background for floating effect
          builder: (context) => AudioPlayer(),
        );

        print('Tapped on: ${ref.read(currentlyPlayingProvider)}');
      },
      child: Container(
        width: double.infinity, // Takes full width of the screen
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.white, // Set a background color for the card
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFE4E1), // Light pink
              Color(0xFFFFDAB9), // Peach puff (slightly orange hue)
              Color(0xFFFFC1C1), // Slightly darker pink
            ],
            stops: [0.0, 0.5, 1.0],
          ),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius:
                  0.5, // Reduced spread radius for a more subtle shadow
              blurRadius: 15, // Increased blur radius for a softer shadow
              offset: Offset(0, 5), // Slightly downward and balanced shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            top: 12.0,
            left: 20.0,
            right: 20.0,
          ), // Add some padding to the text
          child: Align(
            alignment: Alignment.topLeft, // Align text to the top left
            child: Text(
              title,
              style: kRecordingTitle,
            ),
          ),
        ),
      ),
    );
  }
}
