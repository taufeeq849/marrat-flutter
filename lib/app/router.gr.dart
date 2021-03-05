// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../models/mosque/mosque.dart';
import '../ui/views/add_mosque/mosque_info/add_mosque_view.dart';
import '../ui/views/add_mosque/mosque_info/prayer_times/add_prayer_times_view.dart';
import '../ui/views/home/home_view.dart';
import '../ui/views/landing_page/landing_page_view.dart';
import '../ui/views/specific_mosque_view/specific_mosque_view.dart';

class Routes {
  static const String landingPageView = '/';
  static const String homeView = '/home-view';
  static const String addMosqueView = '/add-mosque-view';
  static const String addPrayerTimesView = '/add-prayer-times-view';
  static const String specificMosqueView = '/specific-mosque-view';
  static const all = <String>{
    landingPageView,
    homeView,
    addMosqueView,
    addPrayerTimesView,
    specificMosqueView,
  };
}

class Router extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.landingPageView, page: LandingPageView),
    RouteDef(Routes.homeView, page: HomeView),
    RouteDef(Routes.addMosqueView, page: AddMosqueView),
    RouteDef(Routes.addPrayerTimesView, page: AddPrayerTimesView),
    RouteDef(Routes.specificMosqueView, page: SpecificMosqueView),
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
    AddMosqueView: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddMosqueView(),
        settings: data,
      );
    },
    AddPrayerTimesView: (data) {
      final args = data.getArgs<AddPrayerTimesViewArguments>(nullOk: false);
      return MaterialPageRoute<dynamic>(
        builder: (context) => AddPrayerTimesView(mosqueData: args.mosqueData),
        settings: data,
      );
    },
    SpecificMosqueView: (data) {
      final args = data.getArgs<SpecificMosqueViewArguments>(
        orElse: () => SpecificMosqueViewArguments(),
      );
      return MaterialPageRoute<dynamic>(
        builder: (context) => SpecificMosqueView(
          key: args.key,
          mosque: args.mosque,
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

/// AddPrayerTimesView arguments holder class
class AddPrayerTimesViewArguments {
  final Mosque mosqueData;
  AddPrayerTimesViewArguments({@required this.mosqueData});
}

/// SpecificMosqueView arguments holder class
class SpecificMosqueViewArguments {
  final Key key;
  final Mosque mosque;
  SpecificMosqueViewArguments({this.key, this.mosque});
}
