import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/prayer.dart';
import 'package:stacked/stacked.dart';

class AddPrayerTimesViewModel extends BaseViewModel {
  int currentStep = 0;
  bool complete = false;
  List<Prayer> tempPrayers = prayers;

  next(int length, {String name, location}) {
    currentStep + 1 != length ? goTo(currentStep + 1) : complete = true;
    notifyListeners();
  }

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
    notifyListeners();
  }

  goTo(int step) {
    currentStep = step;
    notifyListeners();
  }
}
