import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SpecificMosqueViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  popBack() {
    return _navigationService.back();
  }

  navigateToEditTimes(Mosque mosque) {
    return _navigationService.navigateTo(Routes.addPrayerTimesView,
        arguments: AddPrayerTimesViewArguments(
            mosqueData: mosque, isNewMosque: false));
  }
}
