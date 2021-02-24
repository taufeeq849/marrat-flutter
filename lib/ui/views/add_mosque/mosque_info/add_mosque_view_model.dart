import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/app/router.gr.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/mosque_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/images/image_picker.dart';
import 'package:marrat/services/location/autocomplete_service.dart';
import 'package:marrat/services/location/geocoder_service.dart';
import 'package:marrat/services/location/geohash_service.dart';
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
  GeoHashService _geoHashService = locator<GeoHashService>();
  NavigationService _navigationService = locator<NavigationService>();

  String nameValidationMessage;
  String locationValidationMessage;
  changeLadiesValue(bool isSelected) {
    mosqueData.hasLadiesFacilities = isSelected;
    notifyListeners();
  }

  changeWudhuValue(bool isSelected) {
    mosqueData.hasWudhuKhana = isSelected;
    notifyListeners();
  }

  uploadImage() async {
    var image = await _imagePickerService.pickImage();
    if (image is File) {
      var downloadUrl = await _firebaseStorageService.uploadImage(image);
      if (downloadUrl == null) {
        return await _dialogService.showDialog(
            title: 'Error', description: downloadUrl, buttonTitle: 'OK');
      }
      mosqueData.mosqueImageUrl = downloadUrl;
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

  getCoordinates(String address) async {
    var result = await _geocoderService.getLatLngFromAddress(address);

    if (result is Coordinates) {
      var geohash = _geoHashService.getGeoHashFromCoords(
          lat: result.latitude, long: result.longitude);

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

  navigateToPrayerTimesStep() {
    return _navigationService.navigateTo(Routes.addPrayerTimesView,
        arguments: AddPrayerTimesViewArguments(mosqueData: mosqueData));
  }

  submit() async {
    bool result = await _firestoreService.uploadMosqueData(mosqueData);
    if (result is bool && result) {
      return await _dialogService.showDialog(
        title: 'Success',
        description: 'You succesfully added a mosque, mashallah!',
      );
    } else {
      return await _dialogService.showDialog(
        title: 'Error',
        description: 'Failed to add a mosque, try again later ',
      );
    }
  }

  int currentStep = 0;
  bool complete = false;
  next(int length, {String name, location}) {
    switch (currentStep) {
      case 0:
        goTo(currentStep + 1);
        break;
      case 1:
        if (name?.length > 0) {
          mosqueData.mosqueName = name;

          goTo(currentStep + 1);
        } else {
          nameValidationMessage = "Name is required";
        }
        break;
      case 2:
        if (location?.length > 0) {
          getCoordinates(location);
          goTo(currentStep + 1);
        } else {
          locationValidationMessage = "Location is required";
        }
        break;
      default:
        currentStep + 1 != length ? goTo(currentStep + 1) : complete = true;
        break;
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
}
