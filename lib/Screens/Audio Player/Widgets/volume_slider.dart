// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:dojo/Services/audio_player_service.dart';
import 'package:dojo/assets/riverpod.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VolumeSlider extends StatelessWidget {
  const VolumeSlider({
    super.key,
    required this.volume,
    required this.ref,
    required this.audioPlayerService,
  });

  final double volume;
  final WidgetRef ref;
  final AudioPlayerService audioPlayerService;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        height: 15.0,
        child: SliderTheme(
          data: SliderThemeData().copyWith(
            thumbShape: RoundSliderThumbShape(
                enabledThumbRadius: 5.0),
            trackHeight: 3.0,
            activeTrackColor: Color(0xFFE2B893),
            thumbColor: Color(0xFFD9A87A),
            //     thumbColor: Color(0xFFD9A87A),
            // progressBarColor: Color(0xFFE2B893)
          ),
          child: Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            onChanged: (value) async {
              ref.read(volumeProvider.notifier).state =
                  value;
              audioPlayerService.audioPlayer
                  .setVolume(value);
            },
          ),
        ),
      ),
    );
  }
}
