// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../ui/views/home/home_view.dart';
import '../ui/views/landing_page/landing_page_view.dart';

class Routes {
  static const String landingPageView = '/';
  static const String homeView = '/home-view';
  static const String editProfileView = '/edit-profile-view';
  static const String fullScreenVideoView = '/full-screen-video-view';
  static const all = <String>{
    landingPageView,
    homeView,
    editProfileView,
    fullScreenVideoView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.landingPageView, page: LandingPageView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.fullScreenVideoView, page: FullScreenVideoView),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    LandingPageView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => LandingPageView(),
        settings: data,
      );
    },
    HomeView: (data) {
      final args = data.getArgs<HomeViewArguments>(
        orElse: () => HomeViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => HomeView(selectedIndex: args.selectedIndex),
        settings: data,
      );
    },
    EditProfileView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => EditProfileView(),
        settings: data,
      );
    },
    FullScreenVideoView: (data) {
      final args = data.getArgs<FullScreenVideoViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => FullScreenVideoView(
          args.video,
          key: args.key,
        ),
        settings: data,
      );
    },
  };
}

/// ************************************************************************
/// Arguments holder classes
/// *************************************************************************

/// HomeView arguments holder class
class HomeViewArguments {
  final int selectedIndex;
  HomeViewArguments({this.selectedIndex = 0});
}

/// FullScreenVideoView arguments holder class
class FullScreenVideoViewArguments {
  final dynamic video;
  final Key key;
  FullScreenVideoViewArguments({@required this.video, this.key});
}
