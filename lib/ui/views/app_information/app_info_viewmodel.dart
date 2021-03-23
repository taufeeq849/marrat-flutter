import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/models/user/user_location.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:marrat/services/url_launcher/url_launcher_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AppInformationViewModel extends BaseViewModel {
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  UrlLauncherService _urlLauncherService = locator<UrlLauncherService>();
  launchVideoUrl() async {
    var result = await _urlLauncherService
        .launchUrl('https://www.youtube.com/watch?v=23xs_pbnCoA');
    if (result) return;
    return await _dialogService.showDialog(
        title: 'Could not launch website',
        description:
            'Please navigate to https://www.youtube.com/watch?v=23xs_pbnCoA instead.');
  }

  launchWebsiteUrl() async {
    var result = await _urlLauncherService.launchUrl('https://taufeeqr.dev/');
    if (result) return;
    return await _dialogService.showDialog(
        title: 'Could not launch website',
        description: 'Please navigate to https://taufeeqr.dev instead.');
  }
}
