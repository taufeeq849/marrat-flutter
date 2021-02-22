import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'app/router.gr.dart' as router;
import 'ui/setup_dialog_ui/setup_dialog_ui.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  setupLocator();
  setupDialogUi();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: router.Routes.landingPageView,
      onGenerateRoute: router.Router(),
      navigatorKey: locator<NavigationService>().navigatorKey,
    );
  }
}
