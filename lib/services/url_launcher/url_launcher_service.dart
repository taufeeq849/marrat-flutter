import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launchUrl(url);
      return true;
    } else {
      print('failed to launch url');
      return false;
    }
  }
}
