import 'package:flutter/material.dart';
import 'package:miserere/objects/Confraternita.dart';
import 'package:miserere/objects/MiserereApi.dart';

class ConfraterniteView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confraternite'),
      ),
      body: Center(
        child: FutureBuilder<List<Confraternita>>(
          future: MiserereApi.getConfraternite(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return new ListView.builder
                (
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    print(snapshot.data[index].urlIcona);
                    return new ListTile(
                      leading: Image.network(snapshot.data[index].urlIcona),
                      title: Text(snapshot.data[index].nome),
                      trailing: Icon(Icons.chevron_right),
                    );
                  }
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}