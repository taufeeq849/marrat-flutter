/*
import 'package:flutter/material.dart';

class TopFollowingSection extends StatelessWidget {
  Function onFollowingPressed, onForYouPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      padding: EdgeInsets.only(bottom: 15.0),
      alignment: Alignment(0.0, 1.0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            GestureDetector(
              onTap: () => model.setShowFollowing(true),
              child: Text(
                'Following',
                style: model.showFollowing
                    ? selectedFeedTextStyle
                    : unSelectedFeedTextStyle,
              ),
            ),
            Container(
              width: 15.0,
            ),
            GestureDetector(
              onTap: () => model.setShowFollowing(false),
              child: Text('For you',
                  style: model.showFollowing
                      ? unSelectedFeedTextStyle
                      : selectedFeedTextStyle),
            )
          ]),
    );
  }
}
*/
