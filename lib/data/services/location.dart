import 'dart:convert';
import 'package:misiontic_template/domain/models/location.dart';
import 'package:misiontic_template/domain/services/misiontic_interface.dart';
import 'package:http/http.dart' as http;

class LocationService implements MisionTicService {
  final String baseUrl = 'misiontic-2022-uninorte.herokuapp.com';
  final String apiKey = 'ZtVeTqq/jRvlMIqROrbB0ePRX5O5HjKiDnjHFo3GSLGr2eJxOUYhS';

  @override
  Future<List<UserLocation>> fecthData({int limit = 5, Map? map}) async {
    var queryParameters = {'limit': limit.toString()};
    var uri = Uri.https(baseUrl, '/location', queryParameters);
    final response = await http.post(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // We add our service ApiKey to the request headers
        'key': apiKey,
      },
      body: json.encode(map),
    );
    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      final List<UserLocation> locations = [];
      for (var location in res['nearme']) {
        locations.add(UserLocation.fromJson(location));
      }
      return locations;
    } else {
      throw Exception('Error on request');
    }
  }
}
