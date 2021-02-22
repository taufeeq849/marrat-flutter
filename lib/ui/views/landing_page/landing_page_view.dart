import 'package:flutter/material.dart';
import 'package:marrat/styles/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'landing_page_viewmodel.dart';

class LandingPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, LandingPageViewModel model, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  width: 300,
                  height: 400,
                  child: Image.asset('assets/images/app_icon.png'),
                ),
                model.errorMessage != null
                    ? Text(
                        model.errorMessage,
                        textAlign: TextAlign.center,
                      )
                    : CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation(primaryColor),
                      ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => LandingPageViewModel(),
      onModelReady: (LandingPageViewModel model) => model.getLocation(),
    );
  }
}
