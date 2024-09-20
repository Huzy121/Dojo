// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:dojo/Screens/Home%20Page/Widgets/recording_tile.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/Screens/Home%20Page/Widgets/custom_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home_page_constants.dart';
import 'package:dojo/Screens/Home%20Page/files_notifier.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart' as path;
import '../Audio Player/audio_player.dart';

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
    final pageController = ref.watch(pageViewControllerProvider);
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
              controller: pageController,
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
