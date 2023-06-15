import 'package:flutter/material.dart';

class DismissibleBackground extends StatelessWidget {
  final Color color;
  final IconData icon;
  final bool isRight;

  const DismissibleBackground({
    super.key,
    required this.color,
    required this.icon,
    this.isRight = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: color,
      alignment: isRight ? Alignment.centerRight : Alignment.centerLeft,
      child: Icon(
        icon,
        color: Colors.white,
      ),
    );
  }
}
