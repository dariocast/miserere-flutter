import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:miserere/objects/TestoMiserere.dart';

class Salmo50 extends StatelessWidget {
  static const routeName = '/salmo';

  @override
  Widget build(BuildContext context) {
    TestoMiserere testo = TestoMiserere.getTesto();
    return Scaffold(
      appBar: AppBar(
        title: Text('Miserere, il Salmo 50'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.event),
            onPressed: () {
              Navigator.pushNamed(context, '/prove');
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemCount: testo.strofe!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  contentPadding: EdgeInsets.all(5.0),
                  title: Text(testo.strofe![index].cantato!),
                  subtitle: Text(testo.strofe![index].letto!),
                );
              },
            )
          ),
          new Container(
            height: 1.5,
            color: Colors.deepPurple,
          ),
          ListTile(
            leading: Icon(Icons.audiotrack,color: Colors.deepPurple,),
            title: Text("La traccia"),
            subtitle: Text("Traccia audio da acoltare e scaricare"),
            trailing: Icon(Icons.chevron_right,color: Colors.deepPurple,),
            onTap: () {
              Navigator.pushNamed(context, '/audio');
            },
          ),
        ],
      )
    );
  }

}