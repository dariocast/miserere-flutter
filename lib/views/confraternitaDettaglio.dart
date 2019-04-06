import 'package:flutter/material.dart';
import 'package:miserere/objects/Confraternita.dart';
import 'package:miserere/objects/Location.dart';
import 'package:miserere/objects/MiserereApi.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ConfraternitaDettaglio extends StatelessWidget {
  static const routeName = '/dettaglio';

  @override
  Widget build(BuildContext context) {
    final Confraternita confraternita =
        ModalRoute.of(context).settings.arguments;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(confraternita.nome),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.location_on)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WebView(
              initialUrl: confraternita.urlInfo,
              javascriptMode: JavascriptMode.unrestricted,
            ),
            FutureBuilder<List<Location>>(
              future:
                  MiserereApi.getLocationByConfraternitaId(confraternita.id),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return new Scaffold(
                    floatingActionButton: FloatingActionButton(
                      child: Icon(Icons.map),
                      elevation: 2.0,
                      //TODO implement map view
                      onPressed: () => Scaffold.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Disponibile a breve'),
                            action: SnackBarAction(
                              label: 'Ok',
                              onPressed: () {},
                            )
                        )
                      ),
                      tooltip: 'Mostra sulla mappa',
                    ),
                    body: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return new ListTile(
                            leading: Text(snapshot.data[index].ora.substring(0,5)),
                            title: Text(snapshot.data[index].tag),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return CircularProgressIndicator();
              },
            ),
          ],
        ),
      ),
    );
  }
}
