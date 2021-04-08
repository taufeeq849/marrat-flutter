import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/services/url_launcher/url_launcher_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddMosqueInfoViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  UrlLauncherService _urlLauncherService = locator<UrlLauncherService>();
  String typeFormUrl = 'https://t6nniphkorx.typeform.com/to/v6ZjV9sW';
  launchUrl() {
  return     _urlLauncherService.launchUrl(typeFormUrl);
  }

  navigateToAddMosqueView() {
    _navigationService.navigateTo(Routes.addMosqueView);
  }
}
