// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:dojo/Widgets/custom_navigation_bar.dart';
import 'package:dojo/assets/constants.dart';
import 'package:dojo/assets/files_notifier.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:path/path.dart' as path;

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
              scrollDirection: Axis.horizontal, // Horizontal scrolling
              itemCount: recordingList.length,
              itemBuilder: (context, index) {
                print('length${recordingList.length}');
                final file = recordingList[index];
                final fileName = path.basename(file).replaceAll('.m4a', '');
                return RecordingTile(title: fileName);
              },
            ),
          ),
          Spacer(), // Add spacer to fill remaining space and push the nav bar to the bottom
        ],
      ),
      bottomNavigationBar:
          CustomNavigationBar(), // Fix navigation bar at the bottom
    );
  }
}

class RecordingTile extends StatelessWidget {
  final String title;
  const RecordingTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tapped on: $title');
      },
      child: Container(
        height: 700.0, // Fixed height for each tile
        width: double.infinity, // Takes full width of the screen
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: kRecordingTitle,
        ),
      ),
    );
  }
}
