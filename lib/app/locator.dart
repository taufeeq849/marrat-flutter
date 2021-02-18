import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/storage/firebase_storage_service.dart';
import 'package:stacked_services/stacked_services.dart';

final locator = GetIt.instance;

@injectableInit
void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => FirebaseStorageService());
  locator.registerLazySingleton(() => SnackbarService());
}
