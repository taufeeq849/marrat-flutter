import 'package:flutter/material.dart';

class MetricDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.5,
      height: 25,
      decoration: BoxDecoration( border: Border(right: BorderSide(color: Colors.grey))),
    );
  }
}
