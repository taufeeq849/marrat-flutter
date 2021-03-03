import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/database/mock_data_service.dart';
import 'package:marrat/services/images/image_picker.dart';
import 'package:marrat/services/location/autocomplete_service.dart';
import 'package:marrat/services/location/geocoder_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';
import 'package:marrat/services/location/location_service.dart';
import 'package:marrat/services/storage/firebase_storage_service.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => LocationService());
  locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => SnackbarService());
  locator.registerLazySingleton(() => GeocoderService());
  locator.registerLazySingleton(() => GeoFlutterFireService());
  locator.registerLazySingleton(() => ImagePickerService());
  locator.registerLazySingleton(() => AutocompleteService());
  locator.registerLazySingleton(() => MockDataService());
}
