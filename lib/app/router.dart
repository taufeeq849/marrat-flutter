import 'package:auto_route/auto_route_annotations.dart';
import 'package:marrat/ui/views/add_mosque/mosque_info/add_mosque_view.dart';
import 'package:marrat/ui/views/add_mosque/prayer_times/add_prayer_times_view.dart';
import 'package:marrat/ui/views/home/home_view.dart';
import 'package:marrat/ui/views/landing_page/landing_page_view.dart';
import 'package:marrat/ui/views/specific_mosque_view/specific_mosque_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LandingPageView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: AddMosqueView),
    MaterialRoute(page: AddPrayerTimesView),
    MaterialRoute(page: SpecificMosqueView),
  ],
)
class $Router {}
