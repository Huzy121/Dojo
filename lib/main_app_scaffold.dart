import 'package:dojo/Screens/Home%20Page/Widgets/custom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MainAppScaffold extends StatelessWidget {
  final Widget body; // Pass the current page content as a body

  const MainAppScaffold({required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          body, // Dynamically display the body (either HomePage, SearchPage, etc.)
      bottomNavigationBar: CustomNavigationBar(), // Persistent navigation bar
    );
  }
}
