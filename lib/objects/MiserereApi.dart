import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miserere/objects/Confraternita.dart';
import 'package:miserere/objects/Location.dart';

class MiserereApi {
  static Future<List<Confraternita>> getConfraternite() async {
    final response = await http.get(Uri.parse(
        'https://dariocast.altervista.org/miserere/api/confraternita.php'));

    if (response.statusCode == 200) {
      List list = List.empty(growable: true);
      List<Confraternita> confraternite = List.empty(growable: true);
      // If server returns an OK response, parse the JSON
      list = json.decode(response.body) as List;
      for (var i = 0; i < list.length; i++) {
        Confraternita confraternita = Confraternita.fromJson(list[i]);
        confraternite.add(confraternita);
      }
      return confraternite;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load confraternite');
    }
  }

  static Future<List<Location>> getLocationByConfraternitaId(String id) async {
    final response = await http.get(Uri.parse(
        'https://dariocast.altervista.org/miserere/api/location.php'));
    if (response.statusCode == 200) {
      List list = List.empty(growable: true);
      List<Location> locations = List.empty(growable: true);
      // If server returns an OK response, parse the JSON
      list = json.decode(response.body) as List;
      for (var i = 0; i < list.length; i++) {
        Location location = Location.fromJson(list[i]);
        if (location.confraternitaId == id) {
          locations.add(location);
        }
      }
      return locations;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load locations');
    }
  }

  static Future<List<Location>> getLocations() async {
    final response = await http.get(Uri.parse(
        'https://dariocast.altervista.org/miserere/api/location.php'));
    if (response.statusCode == 200) {
      List list = List.empty(growable: true);
      List<Location> locations = List.empty(growable: true);
      // If server returns an OK response, parse the JSON
      list = json.decode(response.body) as List;
      for (var i = 0; i < list.length; i++) {
        Location location = Location.fromJson(list[i]);
        locations.add(location);
      }
      return locations;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load locations');
    }
  }
}
