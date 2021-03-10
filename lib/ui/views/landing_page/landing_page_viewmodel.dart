import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LandingPageViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  LocationService _locationService = locator<LocationService>();
  DialogService _dialogService = locator<DialogService>();
  String errorMessage;
  Future getLocation() async {
    var _userLocation = await _locationService.getLocation();
    if (_userLocation is UserLocation) {
      return _navigationService.navigateTo(Routes.homeView);
    } else {
      await _dialogService.showDialog(
          title: 'Missing location',
          description:
              'For some reason, Marrat is not able to access your location. To continue without location, press continue',
          buttonTitle: 'Continue');
      return _navigationService.navigateTo(
        Routes.homeView,
      );
    }
  }
}
