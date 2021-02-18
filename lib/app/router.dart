import 'package:auto_route/auto_route_annotations.dart';
import 'package:marrat/ui/views/home/home_view.dart';
import 'package:marrat/ui/views/landing_page/landing_page_view.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: LandingPageView, initial: true),
    MaterialRoute(page: HomeView), 
  ],
)
class $Router {}
