import 'package:geocoder/geocoder.dart';
import 'package:marrat/app/locator.dart';
import 'package:marrat/constants/constants.dart';
import 'package:marrat/models/mosque/mosque.dart';
import 'package:marrat/models/mosque/mosque_location.dart';
import 'package:marrat/services/database/firestore_service.dart';
import 'package:marrat/services/location/geoflutterfire_service.dart';

class MockDataService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  GeoFlutterFireService _geoHashService = locator<GeoFlutterFireService>();

  List<Coordinates> temp = [
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
    Coordinates(26.162200, 28.0625),
  ];
  List<Mosque> mosques = [];

  uploadMockData() async {
    try {
      int index = 0;
      temp.forEach((element) async {
        var geohash = await _geoHashService.getGeoHashFromCoords(
            lat: element.latitude, long: element.longitude);
        Mosque mosque = Mosque(
            mosqueName: 'Test $index ',
            abnormalPrayerTimes: defaultAbnormalPrayers,
            normalPrayerTimes: defaultNormalPrayers,
            address: 'Houghton estate',
            hasLadiesFacilities: true,
            hasWudhuKhana: true,
            location: MosqueLocation(
                geohash: geohash,
                latitude: element.latitude,
                longitude: element.longitude),
            mosqueImageUrl:
                'https://i.pinimg.com/originals/a1/a2/92/a1a2922fd897cbede0270d1ee3362d04.jpg');
        index++;
        mosques.add(mosque);
      });
      mosques.forEach((element) async {
        await _firestoreService.uploadMosqueData(element);
      });
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
