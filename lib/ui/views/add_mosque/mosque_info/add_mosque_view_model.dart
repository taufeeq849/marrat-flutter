import 'dart:io';
import 'package:geocoder/geocoder.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/mosque_location.dart';
import 'package:marrat/services/images/image_picker.dart';
import 'package:marrat/services/location/autocomplete_service.dart';
import 'package:marrat/services/location/geocoder_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';
import 'package:marrat/services/storage/firebase_storage_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class AddMosqueViewModel extends BaseViewModel {
  Mosque mosque = new Mosque();
  ImagePickerService _imagePickerService = locator<ImagePickerService>();
  FirebaseStorageService _firebaseStorageService =
      locator<FirebaseStorageService>();
  DialogService _dialogService = locator<DialogService>();
  AutocompleteService _autocompleteService = locator<AutocompleteService>();
  GeocoderService _geocoderService = locator<GeocoderService>();
  GeoFlutterFireService _geoHashService = locator<GeoFlutterFireService>();
  NavigationService _navigationService = locator<NavigationService>();

  String nameValidationMessage;
  String locationValidationMessage;
  int currentStep = 0;
  int nameStep = 0;
  int imageStep = 1;
  int locationStep = 2;
  bool complete = false;

  next(int length, {String name, location}) async {
    if (currentStep == nameStep) {
      if (name.length > 0) {
        mosque.mosqueName = name;
        goTo(currentStep + 1);
      } else {
        nameValidationMessage = "Name is required";
      }
    } else if (currentStep == locationStep) {
      //Add Location Step
      if (location.length > 0) {
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

  bool isStepActive(int index) {
    return currentStep == index;
  }

  getPlaceSuggestions(String queryText) async {
    if (queryText.length > 2) {
      var suggestions =
          await _autocompleteService.getPlaceSuggestionsByName(queryText);
      if (suggestions is List<PlaceSuggestion> && suggestions.length > 0) {
        return suggestions;
      }
    }
    return [];
  }

  onPlaceSelected(PlaceSuggestion placeSuggestion) async {
    if (placeSuggestion.photoUrl != null) {
      mosque.mosqueImageUrl = placeSuggestion.photoUrl;
    }
    mosque.mosqueName = placeSuggestion.name;
    mosque.address = placeSuggestion.formattedAddress;
    mosque.location = MosqueLocation(
        latitude: placeSuggestion.lat, longitude: placeSuggestion.long);
    complete = true;
    notifyListeners();
  }

  getLocationAutocompleteSuggestions(String text) async {
    var suggestions =
        await _autocompleteService.getLocationSuggestions(queryText: text);
    if (suggestions is List<LocationSuggestion>) {
      return suggestions;
    }
    return [];
  }

  navigateToAddPrayerTimes() {
    if (mosque.normalPrayerTimes == null) {
      mosque.normalPrayerTimes = defaultNormalPrayers;
    }
    return _navigationService.navigateTo(Routes.addPrayerTimesView,
        arguments:
            AddPrayerTimesViewArguments(isNewMosque: true, mosqueData: mosque));
  }

  uploadImage() async {
    var image = await _imagePickerService.pickImage();
    setBusy(true);
    if (image is File) {
      var downloadUrl = await _firebaseStorageService.uploadImage(image);
      if (downloadUrl == null) {
        setBusy(false);
        return await _dialogService.showDialog(
            title: 'Error', description: downloadUrl, buttonTitle: 'OK');
      }
      mosque.mosqueImageUrl = downloadUrl;
      setBusy(false);
      return;
    }
    setBusy(false);
    return await _dialogService.showDialog(
        title: 'Error', description: image, buttonTitle: 'OK');
  }

  getCoordinates(String address) async {
    mosque.address = address;
    setBusyForObject(mosque, true);
    var result = await _geocoderService.getLatLngFromAddress(address);
    if (result is Coordinates) {
      var geohash = _geoHashService.getGeoHashFromCoords(
          lat: result.latitude, long: result.longitude);
      setBusyForObject(mosque, false);
      return mosque.location = MosqueLocation(
          latitude: result.latitude, longitude: result.longitude);
    } else {
      return await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to get coordinates, try again later',
          buttonTitle: 'Ok');
    }
  }

  editData() {
    complete = false;
    notifyListeners();
  }
}
