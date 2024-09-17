import 'dart:io';

import 'package:dojo/Screens/Home%20Page/home_page.dart';
import 'package:dojo/Screens/Login/login_screen.dart';
import 'package:dojo/Screens/Search/search_page.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with the options from the generated file
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
      // Use StreamBuilder to listen to authentication state changes
      home: AuthWrapper(), // Add this line to decide which screen to show first
      routes: {
        '/search': (context) => SearchPage(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomePage(),
      },
    );
  }
}

// AuthWrapper widget to manage the initial route based on authentication state
class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading spinner while checking the auth state
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // User is signed in, go to HomePage
          return HomePage();
        } else {
          // User is not signed in, go to LoginScreen
          return LoginScreen();
        }
      },
    );
  }
}
