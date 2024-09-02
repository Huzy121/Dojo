// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:dojo/Screens/Audio%20Player/audio_player_constants.dart';
import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class StreamSlider extends StatelessWidget {
  const StreamSlider({
    super.key,
    required Stream<Duration>? positionStream,
    required this.ref,
    required this.audioPlayerService,
    required this.totalDuration,
  }) : _positionStream = positionStream;

  final Stream<Duration>? _positionStream;
  final WidgetRef ref;
  final AudioPlayerService audioPlayerService;
  final Duration totalDuration;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Duration>(
      stream: _positionStream, // Listen to the position stream
      builder: (context, snapshot) {
        // If the snapshot has data, use it; otherwise, default to zero
        Duration progress = snapshot.data ?? Duration.zero;
    
        // Debug prints for StreamBuilder data
        print('StreamBuilder Progress: $progress');
    
        return ProgressBar(
          thumbRadius: 5.0,
          thumbColor: Color(0xFFD9A87A),
          progressBarColor: Color(0xFFE2B893),
          timeLabelTextStyle: audioPlayerTitle,
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
    );
  }
}
