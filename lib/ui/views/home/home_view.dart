import 'package:flutter/material.dart';
import 'package:marrat/styles/app_colors.dart';
import 'package:marrat/ui/views/navbar_views/view_times_view/discover_view.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StatelessWidget {
  int selectedIndex;

  HomeView({this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      onModelReady: (model) => model.setIndex(selectedIndex),
      builder: (context, model, child) {
        return Scaffold(
          body: getViewforIndex(model.currentIndex),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black,
            selectedItemColor: primaryColor,
            currentIndex: model.currentIndex,
            onTap: model.setIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(
                    Icons.time_to_leave,
                  ),
                  label: 'View Times'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.upload_outlined), label: 'Upload Mosque'),
            ],
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget getViewforIndex(int index) {
    switch (index) {
      case 0:
        return DiscoverView();
      case 1:
        return DiscoverView();
      default:
        return DiscoverView();
    }
  }
}
