import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingPageViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  LocationService _locationService = locator<LocationService>();
  String errorMessage;
  Future getLocation() async {
    var _userLocation = await _locationService.getLocation();
    if (_userLocation is UserLocation) {
      _navigationService.navigateTo(Routes.homeView);
    } else {
      errorMessage = _userLocation; 
      notifyListeners();
      return _userLocation;
    }
  }

  Future handleStartUpLogic() async {
    await Future.delayed(Duration(seconds: 1));
    var hasUserLoggedIn = true;
    if (hasUserLoggedIn) {
      _navigationService.navigateTo(Routes.homeView);
    }
  }
}
