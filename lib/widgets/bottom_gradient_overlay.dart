import 'package:flutter/cupertino.dart';

class BottomGradientOverlay extends StatelessWidget {
  final Color color;

  const BottomGradientOverlay(this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.center,
          colors: [color, color.withOpacity(0)],
        ),
      ),
    );
  }
}
