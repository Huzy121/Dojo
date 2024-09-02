// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

class AudioPlayer extends ConsumerStatefulWidget {
  @override
  _AudioPlayerState createState() => _AudioPlayerState();
}

class _AudioPlayerState extends ConsumerState<AudioPlayer> {
  Stream<Duration>? _positionStream;
  
  @override
  void initState() {
    super.initState();
    _positionStream =
        ref.read(audioPlayerServiceProvider).audioPlayer.onPositionChanged;
    ref
        .read(audioPlayerServiceProvider)
        .audioPlayer
        .onPlayerComplete
        .listen((event) {
      ref.read(isPlayingProvider.notifier).state = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerService = ref.watch(audioPlayerServiceProvider);
    final progressValue = ref.watch(positionProvider);
    final totalDuration = ref.watch(audioDurationProvider);
    final isPlaying = ref.watch(isPlayingProvider);
    print('Total Duration: $totalDuration');
    Duration progress = Duration.zero;

    if (progressValue is AsyncData) {
      progress = progressValue.value!;
    }

    // Print statements to debug progress and duration
    print('Current Progress: $progress');
    print('Total Duration: $totalDuration');

    return Padding(
      padding: const EdgeInsets.only(
        left: 20.0,
        right: 20.0,
        bottom: 20.0, // Padding to make it look detached from the bottom
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0), // Rounded corners
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Shadow color
              spreadRadius: 2,
              blurRadius: 10,
              offset: Offset(0, 4), // Downward shadow for floating effect
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0), // Padding inside the modal
          child: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              height: 220,
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    StreamBuilder<Duration>(
                      stream: _positionStream, // Listen to the position stream
                      builder: (context, snapshot) {
                        // If the snapshot has data, use it; otherwise, default to zero
                        Duration progress = snapshot.data ?? Duration.zero;

                        // Debug prints for StreamBuilder data
                        print('StreamBuilder Progress: $progress');

                        return ProgressBar(
                          onSeek: (duration) {
                            ref
                                .read(audioPlayerServiceProvider)
                                .seekTo(duration);
                          },
                          onDragEnd: () => audioPlayerService.playAudio(ref),
                          progress: progress,
                          total: totalDuration, // Total duration of the audio
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(ref.read(currentlyPlayingProvider)),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(IonIcons.arrow_back_circle),
                          onPressed: () {},
                        ),
                        SizedBox(width: 15.0),
                        IconButton(
                          icon:
                              Icon(isPlaying ? IonIcons.pause : IonIcons.play),
                          onPressed: () async {
                            ref.read(isPlayingProvider.notifier).state =
                                !ref.read(isPlayingProvider);
                            !isPlaying
                                ? await audioPlayerService.playAudio(ref)
                                : await audioPlayerService.pauseAudio();
                          },
                        ),
                        SizedBox(width: 15.0),
                        IconButton(
                          icon: Icon(IonIcons.arrow_forward_circle),
                          onPressed: () {},
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Volume Icon'),
                        SizedBox(width: 15.0),
                        Text('Volume Slider'),
                      ],
                    ),
                  ],
                ),
              ),
            ), // Your NewRecording widget
          ),
        ),
      ),
    );
  }
}
