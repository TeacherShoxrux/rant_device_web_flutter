import 'package:flutter/material.dart';

class CustomElevatedButtonIcon extends StatelessWidget {
  const CustomElevatedButtonIcon({super.key, required this.onPressed, required this.text, required this.icon, this.bgColor});
  final VoidCallback onPressed;
  final String text;
  final Widget icon;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(text),
      style: ElevatedButton.styleFrom(backgroundColor: bgColor),

    );
  }
}
