import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marrat/styles/app_colors.dart';

class BottomNavIcons {
  BottomNavIcons._();

  static ImageIcon inboxIcon(bool isSelected) => ImageIcon(
        AssetImage(
          "assets/icons/bottom_nav_icons/email.png",
        ),
        color: isSelected ? primaryColor : Colors.black,
      );

  static ImageIcon homeIcon(bool isSelected) => ImageIcon(
        AssetImage(
          "assets/icons/bottom_nav_icons/home.png",
        ),
        color: isSelected ? primaryColor : Colors.black,
      );

  static ImageIcon profileIcon(bool isSelected) => ImageIcon(
        AssetImage(
          "assets/icons/bottom_nav_icons/user.png",
        ),
        color: isSelected ? primaryColor : Colors.black,
      );
}
