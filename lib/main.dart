import 'dart:io';

import 'package:dojo/Screens/Home%20Page/home_page.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final Directory? localDir = Platform.isIOS
      ? await getApplicationDocumentsDirectory()
      : await getExternalStorageDirectory();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
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
      debugShowCheckedModeBanner: false,
      title: 'DOJO',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFFF9F1),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
