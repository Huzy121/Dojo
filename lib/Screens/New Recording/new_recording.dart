// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class NewRecording extends ConsumerWidget {
  String title = '';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
        bottom: 25.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFFFF9F1),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 400,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Recording Title: ',
                      style: GoogleFonts.interTight(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB3714A)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Color(0xFFB3714A)),
                        ),
                      ),
                      autofocus: true,
                      onChanged: (newText) {
                        title = newText;
                        ref.read(recordingTitleProvider.notifier).state = ref
                            .read(audioRecorderServiceProvider)
                            .capitalizeEachWord(newText);
                        print(
                            'New Name is: ${ref.read(recordingTitleProvider.notifier).state}');
                      },
                    ),
                    SizedBox(height: 50.0),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFAF1E8),
                        shadowColor: Colors.black.withOpacity(0.25),
                        elevation: 4,
                      ),
                      onPressed: () async {
                        if (ref.read(recordingTitleProvider.notifier).state !=
                            '') {
                          await ref
                              .read(audioRecorderServiceProvider)
                              .renameAudio(ref);

                          Navigator.pop(context, ref);
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please Enter a Valid Title",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.transparent,
                              textColor: Colors.red,
                              fontSize: 16.0);
                        }
                      },
                      child: Text(
                        'Save',
                        style: GoogleFonts.interTight(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Color(0xFFB3714A),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
