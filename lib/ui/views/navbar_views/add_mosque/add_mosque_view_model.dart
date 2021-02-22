import 'dart:io';

import 'package:marrat/app/locator.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/mosque_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/images/image_picker.dart';
import 'package:marrat/services/location/autocomplete_service.dart';
import 'package:marrat/services/location/geocoder_service.dart';
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
    var result = await _geocoderService.getAddressFromLocation(address);
    if (result is MosqueLocation) {
      return mosqueData.location = result;
    } else {
      return await _dialogService.showDialog(
          title: 'Error',
          description: 'Failed to get coordinates, try again later',
          buttonTitle: 'Ok');
    }
  }

  validateFields(String name, String location) {
    nameValidationMessage = null;
    locationValidationMessage = null;
    bool isValid = true;

    if (name.length == 0) {
      nameValidationMessage = "Name Required";
      isValid = false;
    }
    if (location.length == 0) {
      locationValidationMessage = "Location Required";
      isValid = false;
    }
    notifyListeners();
    return isValid;
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

  onSubmit(String name, String location) {
    var valid = validateFields(name, location);
    if (valid) {
      return submit();
    }
  }
}
