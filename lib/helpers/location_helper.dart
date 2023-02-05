import 'dart:convert';

import 'package:http/http.dart' as http;

class LocationHelper {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude,
  }) {
    // return 'https://www.openstreetmap.org/?mlat=$latitude&mlon=$longitude#map=19/$latitude/$longitude';
    return 'http://b.tile.openstreetmap.org/8/${latitude.toInt()}/${longitude.toInt()}.png';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    var url = Uri.https(
        'https://nominatim.openstreetmap.org/reverse?lat=$lat&lon=$long&format=json');

    // var response = await http.get(url, headers: {'User-Agent': OSM_API_KEY});
    var response = await http.get(url);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    return jsonDecode(response.body)['results'][0]['display_name'];
  }
}
