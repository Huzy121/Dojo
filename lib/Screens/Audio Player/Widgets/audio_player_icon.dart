// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:dojo/Screens/Audio%20Player/audio_player_constants.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class audioPlayerIcon extends StatelessWidget {
  final PhosphorIconData phosphorIcon;
  const audioPlayerIcon({
    required this.phosphorIcon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      phosphorIcon,
      color: audioPlayerIcons,
    );
  }
}
