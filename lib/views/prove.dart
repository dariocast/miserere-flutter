import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProveView extends StatelessWidget {
  static const routeName = '/prove';

  Future<String> fetchProve() async {
    final response = await http.get(
        Uri.parse('http://dariocast.altervista.org/miserere/pages/prove.php'));
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return response.body;
    } else {
      throw Exception(
          'Impossibile caricare il programma delle prove del miserere');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calendario Prove"),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchProve(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var json = jsonDecode(snapshot.data!);
                return new ListView.builder(
                    itemCount: json.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new ListTile(
                        title: Text(json[index]['descrizione']),
                        subtitle: Text(json[index]['giorno']),
                        trailing: Text(json[index]['ora']),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        ));
  }
}
