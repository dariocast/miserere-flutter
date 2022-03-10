import 'dart:io';
import 'package:flutter/material.dart';
import 'package:miserere/views/audioView.dart';
import 'package:miserere/views/confraternitaDettaglio.dart';
import 'package:miserere/views/confraternite.dart';
import 'package:miserere/views/notifiche.dart';
import 'package:miserere/views/programma.dart';
import 'package:miserere/views/prove.dart';
import 'package:miserere/views/salmo50.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  await Supabase.initialize(
      url: 'https://fzftwinmjwcanncalblz.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZ6ZnR3aW5tandjYW5uY2FsYmx6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NDY5MzYzNDcsImV4cCI6MTk2MjUxMjM0N30.LjfdAFRkhvsagtMOomrnG0o0r8K3IbMk9PQ2sJPgnpI');
  runApp(Miserere());
}

class Miserere extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //routing info
      initialRoute: '/',
      routes: {
        ConfraterniteView.routeName: (context) => ConfraterniteView(),
        ConfraternitaDettaglio.routeName: (context) => ConfraternitaDettaglio(),
        Salmo50.routeName: (context) => Salmo50(),
        AudioView.routeName: (context) => AudioView(),
        ProgrammaView.routeName: (context) => ProgrammaView(),
        ProveView.routeName: (context) => ProveView(),
        NotificheView.routeName: (context) => NotificheView(),
      },
      title: 'Miserere',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        fontFamily: "Roboto",
      ),
      home: AppHomePage(title: 'Miserere'),
    );
  }
}

class AppHomePage extends StatefulWidget {
  AppHomePage({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  int ncount = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getNotificheCount();
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title!),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: ncount <= 0
                  ? new Icon(
                      Icons.notifications,
                      color: Colors.yellow,
                    )
                  : new Stack(
                      children: <Widget>[
                        new Icon(
                          Icons.notifications,
                          color: Colors.yellow,
                        ),
                        new Positioned(
                          right: 0,
                          child: new Container(
                            padding: EdgeInsets.all(1),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 12,
                              minHeight: 12,
                            ),
                            child: new Text(
                              '$ncount',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      ],
                    ),
              onPressed: () {
                Navigator.pushNamed(context, '/notifiche');
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(
                Icons.queue_music,
                color: Colors.black,
              ),
              title: Text('Miserere'),
              subtitle: Text('Il salmo 50'),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.black,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/salmo');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.event,
                color: Colors.deepOrange,
              ),
              title: Text('Programma Quaresima 2019'),
              subtitle: Text('Parrocchia San Michele Arcangelo'),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.deepOrange,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/programma');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.people,
                color: Colors.lightBlue,
              ),
              title: Text('Confraternite'),
              subtitle: Text('Arciconfraternite e processioni'),
              trailing: Icon(
                Icons.chevron_right,
                color: Colors.lightBlue,
              ),
              onTap: () {
                Navigator.pushNamed(context, '/confraternite');
              },
            ),
            ListTile(
              leading: Icon(
                Icons.map,
                color: Colors.grey,
              ),
              title: Text('Cosa fare'),
              subtitle: Text('Cosa c\'è nella prossima ora'),
              trailing: Icon(
                Icons.not_interested,
                color: Colors.grey,
              ),
              enabled: false,
            ),
          ],
        ),
      ),
      onWillPop: () async {
        return await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('Sei sicuro?'),
            content: new Text('Vuoi davvero chiudere l \'app Miserere?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Si'),
              ),
            ],
          ),
        );
      },
    );
  }

  _getNotificheCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifiche = (prefs.getStringList('notifiche') ?? List.empty());
    setState(() {
      ncount = notifiche.length;
    });
  }

  _setNotifica(String notifica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifiche = (prefs.getStringList('notifiche') ?? List.empty());
    notifiche.add(notifica);
    await prefs.setStringList('notifiche', notifiche);
  }
}
