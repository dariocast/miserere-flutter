import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProgrammaView extends StatelessWidget {
  static const routeName = '/programma';

  Future<String> fetchProgramma() async {
    final response = await http
        .get('http://dariocast.altervista.org/miserere/pages/quaresima.php');
    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return response.body;
    } else {
      throw Exception('Impossibile caricare il programma della quaresima');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Incontri di Quaresima 2019"),
        ),
        body: Center(
          child: FutureBuilder<String>(
            future: fetchProgramma(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var json = jsonDecode(snapshot.data);
                return new ListView.builder(
                    itemCount: json['appuntamenti'].length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return new ListTile(
                          title: Text(
                              json['appuntamenti'][index]['titolo']['testo']),
                          subtitle: Text(
                              json['appuntamenti'][index]['data']['testo']),
                          trailing: Icon(Icons.info_outline),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                      title: new Text(json['appuntamenti'][index]['titolo']['testo']),
                                      content: ListTile(
                                        title: Text(json['appuntamenti'][index]['data']['testo']),
                                        subtitle: Text(json['appuntamenti'][index]['luogo']),
                                        trailing: Text(json['appuntamenti'][index]['data']['ora']),
                                      )
                                    ));
                          });
                    });
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              // By default, show a loading spinner
              return CircularProgressIndicator();
            },
          ),
        )
    );
  }
}
