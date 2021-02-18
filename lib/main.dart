import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';
import 'app/locator.dart';
import 'app/router.gr.dart' as router;
import 'ui/setup_dialog_ui/setup_dlalog_ui.dart';

List<CameraDescription> cameras = [];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setupLocator();

  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    await locator<DialogService>()
        .showDialog(title: 'Error', description: 'Please try relaunching!');
  }
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
