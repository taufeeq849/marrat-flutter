import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle mainHeadingStyle({bool isWhite = false}) => TextStyle(
    color: isWhite ? Colors.white : Colors.black,
    fontFamily: 'Montserrat',
    fontSize: 30,
    fontWeight: FontWeight.bold);

final TextStyle appBarHeadingStyle = TextStyle(
    color: Colors.black,
    fontFamily: 'Montserrat',
    fontSize: 20,
    fontWeight: FontWeight.bold);

final TextStyle usernameTextStyle = TextStyle(
  color: Colors.black,
  fontFamily: 'Montserrat',
  fontSize: 16,
);
final TextStyle subHeadingStyle = TextStyle(
  color: Colors.grey,
  fontFamily: 'Montserrat',
  fontSize: 14,
);
final kHintTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: 'OpenSans',
);

final kLabelStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);
final registerScreenTextBoxStyle = BoxDecoration(
  color: Colors.blue,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

final recordingScreenTextStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final bioTextStyle = TextStyle(
    fontWeight: FontWeight.normal, fontSize: 14, fontFamily: 'Montserrat');
final recordingIconsTextStyle = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 10,
    fontFamily: 'Montserrat',
    color: Colors.white);

TimerTextStyle(bool isSelected) => TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 10,
    fontFamily: 'Montserrat',
    color: isSelected ? Colors.white : Colors.grey);

final TextStyle selectedFeedTextStyle = TextStyle(
    fontSize: 17.0, fontWeight: FontWeight.bold, fontFamily: 'Montserrat', color: Colors.white);
final TextStyle unSelectedFeedTextStyle = TextStyle(
    fontSize: 14.0, fontWeight: FontWeight.normal, fontFamily: 'Montserrat', color: Colors.white);
