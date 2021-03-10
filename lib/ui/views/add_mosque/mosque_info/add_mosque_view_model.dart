import 'dart:io';
import 'dart:math';
import 'package:geocoder/geocoder.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/mosque_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/images/image_picker.dart';
import 'package:marrat/services/location/autocomplete_service.dart';
import 'package:marrat/services/location/geocoder_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';
import 'package:marrat/services/storage/firebase_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddMosqueViewModel extends BaseViewModel {
  Mosque mosqueData = new Mosque();
  ImagePickerService _imagePickerService = locator<ImagePickerService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  DialogService _dialogService = locator<DialogService>();
  AutocompleteService _autocompleteService = locator<AutocompleteService>();
  GeocoderService _geocoderService = locator<GeocoderService>();
  FirestoreService _firestoreService = locator<FirestoreService>();
  GeoFlutterFireService _geoHashService = locator<GeoFlutterFireService>();
  NavigationService _navigationService = locator<NavigationService>();

  String nameValidationMessage;
  String locationValidationMessage;
  static const int imageStep = 0;
  static const int nameStep = 1;
  static const int locationStep = 2;
  static const int ammenitiesStep = 3;
  uploadImage() async {
    var image = await _imagePickerService.pickImage();
    setBusy(true);
    if (image is File) {
      var downloadUrl = await _firebaseStorageService.uploadImage(image);
      if (downloadUrl == null) {
        return await _dialogService.showDialog(
            title: 'Error', description: downloadUrl, buttonTitle: 'OK');
      }
      mosqueData.mosqueImageUrl = downloadUrl;
      setBusy(false);
      notifyListeners();
      return;
    }
    return await _dialogService.showDialog(
        title: 'Error', description: image, buttonTitle: 'OK');
  }

  getAutocompleteSuggestions(String text) async {
    var suggestions =
        await _autocompleteService.getSuggestions(queryText: text);
    if (suggestions is List<Suggestion>) {
      return suggestions;
    }
  }

  navigateToAddPrayerTimes() {
    if (mosqueData.normalPrayerTimes == null) {
      mosqueData.normalPrayerTimes = defaultNormalPrayers;
    }
    return _navigationService.navigateTo(Routes.addPrayerTimesView,
        arguments: AddPrayerTimesViewArguments(
            isNewMosque: true, mosqueData: mosqueData));
  }

  getCoordinates(String address) async {
    mosqueData.address = address;
    setBusyForObject(mosqueData, true);

    var result = await _geocoderService.getLatLngFromAddress(address);

    if (result is Coordinates) {
      var geohash = _geoHashService.getGeoHashFromCoords(
          lat: result.latitude, long: result.longitude);
      setBusyForObject(mosqueData, false);
      return mosqueData.location = MosqueLocation(
          geohash: geohash,
          latitude: result.latitude,
          longitude: result.longitude);
    } else {
      return await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to get coordinates, try again later',
          buttonTitle: 'Ok');
    }
  }

  int currentStep = 0;
  bool complete = false;
  next(int length, {String name, location}) async {
    if (currentStep == 1) {
      if (name?.length > 0) {
        mosqueData.mosqueName = name;
        goTo(currentStep + 1);
      } else {
        nameValidationMessage = "Name is required";
      }
    } else if (currentStep == 2) {
      //Add Location Step
      if (location?.length > 0) {
        await getCoordinates(location);
        complete = true;
      } else {
        locationValidationMessage = "Location is required";
      }
    } else {
      currentStep + 1 != length ? goTo(currentStep + 1) : complete = true;
    }
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

  editData() {
    complete = false;
    notifyListeners();
  }
}
