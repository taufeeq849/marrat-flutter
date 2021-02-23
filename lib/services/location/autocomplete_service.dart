import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:marrat/keys/api_keys.dart';

class AutocompleteService {
  final client = Client();
  getSuggestions({String queryText = ''}) async {
    final request =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$queryText&types=address&language=za&components=country:za&key=$GOOGLE_PLACES_API_KEY';
    final response = await client.get(request);

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      if (result['status'] == 'OK') {
        print(result);
        // compose suggestions in a list
        return result['predictions']
            .map<Suggestion>((p) =>
                Suggestion(address: p['description'], placeId: p['place_id']))
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
}

class Suggestion {
  String placeId;
  String address;

  Suggestion({@required this.placeId, @required this.address});
}
