import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddMosqueInfoViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  navigateToAddMosqueView() {
    _navigationService.navigateTo(Routes.addMosqueView);
  }
}
