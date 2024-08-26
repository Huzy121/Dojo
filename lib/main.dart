import 'dart:io';

import 'package:dojo/Screens/home_page.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory? localDir = Platform.isIOS
      ? await getApplicationDocumentsDirectory()
      : await getExternalStorageDirectory();

  runApp(
    ProviderScope(
      overrides: [
        localDirectoryProvider.overrideWithValue(localDir!.path),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DOJO',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
