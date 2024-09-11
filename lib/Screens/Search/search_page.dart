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
    final searchQuery = ref.watch(searchQueryProvider);
    final searchController = ref.read(searchControllerProvider);
    return Scaffold(
      body: Column(
        children: [
          TextField(
            autofocus: true,
            controller: searchController,
            decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(PhosphorIcons.x()),
                onPressed: () {
                  searchController.clear();
                  ref.read(searchQueryProvider.notifier).state = '';
                },
              ),
            ),
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).state = value;
              FocusScope.of(context).autofocus;
              print('search: $value');
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: recordingList.length,
              itemBuilder: (context, index) {
                final recording = recordingList[index];
                print('recording $recording');
                if (searchQuery == '') {
                  return ListTile(
                    title: Text(recording.replaceAll('.m4a', '')),
                    onTap: () {},
                  );
                } else {
                  if (recording
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase())) {
                    print('recording title: $recording');
                    return ListTile(
                      title: Text(recording.replaceAll('.m4a', '')),
                      onTap: () {},
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
