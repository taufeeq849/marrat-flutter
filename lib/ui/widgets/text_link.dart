import 'package:flutter/material.dart';

class TextLink extends StatelessWidget {
  final String text;
  final Function onPressed;
  final TextStyle textStyle;

  const TextLink(this.text,
      {this.onPressed,
      this.textStyle = const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 14,
          fontFamily: 'Montserrat')});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Text(text, style: textStyle),
    );
  }
}
