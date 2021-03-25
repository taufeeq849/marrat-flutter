import 'package:flutter/material.dart';
import 'package:marrat/ui/widgets/webview_widget.dart';
import 'package:stacked/stacked.dart';
import 'app_info_viewmodel.dart';
import 'dart:async';

class AppInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, AppInformationViewModel model, child) {
        String url = 'https://marrat.crd.co/';
        return WebViewWidget(
          url: url,
        );
        /* This is for the initial planned view, testing out webview;
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Marrat',
                style: kcUnderlinedStyleMain,
              ),
              verticalSpaceMedium,
              Text(
                'Marrat intends to bring you closer to the masjid by showing you the closest mosques to your location. Additionally, you can view the times for each prayer. The app intends to be community maintained so please feel free to contribute.',
                style: kcSubHeadingStyle(Colors.black),
                textAlign: TextAlign.start,
              ),
              verticalSpaceLarge,
              InkWell(
                child: Text('Tap here to watch a video demonstration',
                    textAlign: TextAlign.center, style: kcUnderlinedStyleMain),
                onTap: () => model.launchVideoUrl(),
              ),
              verticalSpaceLarge,
              InkWell(
                child: Text(
                  'Developed by Taufeeq Razak',
                  style: kcUnderlinedStyleMain,
                ),
                onTap: () => model.launchWebsiteUrl(),
              ),
            ],
          ),
        );
 */
      },
      viewModelBuilder: () => AppInformationViewModel(),
      onModelReady: (AppInformationViewModel model) {},
    );
  }
}
