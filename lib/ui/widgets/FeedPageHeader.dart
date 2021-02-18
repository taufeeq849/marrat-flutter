import 'package:flutter/material.dart';

class FeedPageHeader extends StatelessWidget {
  const FeedPageHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Following",
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "|",
          style: TextStyle(
            color: Colors.white.withOpacity(0.3),
            fontSize: 17,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Text(
          "For You",
          style: TextStyle(
              color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500),
        )
      ],
    );
  }
}
