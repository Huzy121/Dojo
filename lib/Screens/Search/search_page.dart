// search_page.dart

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dojo/Screens/Home%20Page/files_notifier.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingList = ref.read(recordingListProvider);
    final searchController = ref.read(searchControllerProvider);
    final filteredListProvider = ref.watch(filteredAudioListProvider);
    final pageController = ref.read(pageViewControllerProvider);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              autofocus: true,
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search...', // Optional hint text
                filled: true,
                fillColor: Colors
                    .transparent, // Background color to give it a "floating" look
                suffixIcon: IconButton(
                  icon: Icon(PhosphorIcons.x()),
                  onPressed: () {
                    searchController.clear();
                    ref.read(searchQueryProvider.notifier).state = '';
                  },
                ),
                // Apply rounded borders for the floating style
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0), // Rounded corners
                  borderSide:
                      BorderSide(color: Color(0xFFB3714A)), // No visible border
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide(
                    color: Color(0xFFB3714A), // Optional color when focused
                    width: 2.0, // Thicker border when focused
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                    vertical: 15.0,
                    horizontal:
                        20.0), // Adjust the padding for a comfortable look
              ),
              onChanged: (value) {
                ref.read(searchQueryProvider.notifier).state = value;
                print('search: $value');
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredListProvider.length,
              itemBuilder: (context, index) {
                final recording = filteredListProvider[index];
                return ListTile(
                  title: Text(recording.replaceAll('.m4a', '')),
                  onTap: () {
                    final index = recordingList.indexOf(recording);
                    pageController.jumpToPage(index);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
