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
    final List<Tab> tabs = <Tab>[
      Tab(child: Text('LEFT')),
      Tab(child: Text('RIGHT')),
    ];
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(confraternita.nome),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.map)),
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
                  return new ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext ctxt, int index) {
                        return new ListTile(
                          leading: Text(snapshot.data[index].ora.substring(0,5)),
                          title: Text(snapshot.data[index].tag),
                        );
                      });
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
