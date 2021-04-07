import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:marrat/keys/api_keys.dart';

class AutocompleteService {
  final client = Client();
  getLocationSuggestions({String queryText = ''}) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$queryText&types=address&language=za&components=country:za&key=$GOOGLE_PLACES_API_KEY';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        // compose suggestions in a list
        return result['predictions']
            .map<LocationSuggestion>((p) => LocationSuggestion(
                address: p['description'], placeId: p['place_id']))
            .toList();
      }
      if (result['status'] == 'ZERO_RESULTS') {
        return [];
      }
      return result['error_message'];
    } else {
      return "Failed to fetch suggestions";
    }
  }

  getPlaceSuggestionsByName(String querytext) async {
    try {
      String request =
          "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?inputtype=textquery&fields=photos,formatted_address,name,geometry&key=$GOOGLE_PLACES_API_KEY&region=za&type=mosque&input=$querytext";
      final response = await client.get(request);

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        if (result['status'] == 'ZERO_RESULTS') {
          return [];
        }
        if (result['status'] == 'OK') {
          // compose suggestions in a list
          return result['candidates'].map<PlaceSuggestion>((p) {
            String photoRef = '';
            if (p['photos'] != null) {
              photoRef = p['photos'][0]['photo_reference'];
            }
            String imageUrl =
                'https://maps.googleapis.com/maps/api/place/photo?photoreference=$photoRef&sensor=false&maxheight=1600&maxwidth=1600&key=$GOOGLE_PLACES_API_KEY';
            return PlaceSuggestion(
              name: p['name'],
              formattedAddress: p['formatted_address'],
              photoRef: photoRef,
              photoUrl: imageUrl,
              lat: p['geometry']['location']['lat'],
              long: p['geometry']['location']['lng'],
            );
          }).toList();
        }
        return result['error_message'];
      } else {
        return "Failed to fetch suggestions";
      }
    } catch (e) {
      print(e.toString());

      return e.toString();
    }
  }

  getImageUrlfromPhotoRef(String photoRef) async {
    String request =
        'https://maps.googleapis.com/maps/api/place/photo?photoreference=$photoRef&sensor=false&maxheight=1600&maxwidth=1600&key=$GOOGLE_PLACES_API_KEY';
    final response = await client.get(request);
    print(response.toString());
    if (response != null) {
      return response.toString();
    }
    return null;
  }
}

class LocationSuggestion {
  String placeId;
  String address;

  LocationSuggestion({@required this.placeId, @required this.address});
}

class PlaceSuggestion {
  final String name;
  final String photoRef;
  final String photoUrl;
  final double lat;
  final double long;
  final String formattedAddress;

  PlaceSuggestion(
      {this.name,
      this.photoUrl,
      this.photoRef,
      this.lat,
      this.long,
      this.formattedAddress});
}
