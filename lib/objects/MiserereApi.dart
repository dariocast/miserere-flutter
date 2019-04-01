import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:miserere/objects/Confraternita.dart';

class MiserereApi {

  static Future<List<Confraternita>> getConfraternite() async {
    final response = await http.get('https://dariocast.altervista.org/miserere/api/confraternita.php');

    if (response.statusCode == 200) {
      List list = List();
      List<Confraternita> confraternite = List<Confraternita>();
      // If server returns an OK response, parse the JSON
      list = json.decode(response.body) as List;
      for(var i = 0; i < list.length; i++){
        Confraternita confraternita = Confraternita.fromJson(list[i]);
        confraternite.add(confraternita);
      }
      return confraternite;
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }
}