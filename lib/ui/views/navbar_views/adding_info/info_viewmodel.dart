import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class InfoViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  navigateToAddDetails() {
    _navigationService.navigateTo(Routes.addMosqueView);
  }
}
