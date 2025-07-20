import 'package:flutter/material.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.volume_off_rounded, color: Colors.grey.shade500);
  }
}
