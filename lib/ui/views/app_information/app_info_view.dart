import 'package:flutter/material.dart';
import 'package:marrat/styles/text_styles.dart';
import 'package:marrat/styles/ui_helpers.dart';
import 'package:marrat/ui/widgets/youtube_video_player.dart';
import 'package:stacked/stacked.dart';
import 'app_info_viewmodel.dart';

class AppInformationView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (context, AppInformationViewModel model, child) {
        return Padding(
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
      },
      viewModelBuilder: () => AppInformationViewModel(),
      onModelReady: (AppInformationViewModel model) {},
    );
  }
}
