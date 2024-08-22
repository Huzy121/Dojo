// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unnecessary_import, use_key_in_widget_constructors, library_private_types_in_public_api, sort_child_properties_last

import 'package:dojo/Widgets/custom_navigation_bar.dart';
import 'package:dojo/assets/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Container(
                constraints: BoxConstraints.expand(),
                child: SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 10.0, left: 10.0, right: 10.0),
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
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 50, right: 50.0, top: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: GestureDetector(
                                child: Container(
                                  padding: EdgeInsets.only(
                                    left: 20.0,
                                    top: 20.0,
                                  ),
                                  child: Text(
                                    'Interstitial Lung Disease',
                                    style: kRecordingTitle,
                                  ),
                                  height: 400.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(
                                        20), // Adjust the radius here
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          CustomNavigationBar(), // Custom navigation bar at the bottom
        ],
      ), 
    );
  }
}
