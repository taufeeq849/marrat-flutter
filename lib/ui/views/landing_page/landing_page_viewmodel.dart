import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingPageViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();

  Future handleStartUpLogic() async {
    await Future.delayed(Duration(seconds: 1));
    var hasUserLoggedIn = true;
    if (hasUserLoggedIn) {
      _navigationService.navigateTo(Routes.homeView);
    }
  }
}
