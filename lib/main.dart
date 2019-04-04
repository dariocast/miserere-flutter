import 'dart:io';
import 'package:flutter/material.dart';
import 'package:miserere/views/audioView.dart';
import 'package:miserere/views/confraternitaDettaglio.dart';
import 'package:miserere/views/confraternite.dart';
import 'package:miserere/views/notifiche.dart';
import 'package:miserere/views/programma.dart';
import 'package:miserere/views/prove.dart';
import 'package:miserere/views/salmo50.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(Miserere());

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
  AppHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppHomePageState createState() => _AppHomePageState();
}

class _AppHomePageState extends State<AppHomePage> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  int ncount = 0;
  @override
  void initState() {
    super.initState();
    firebaseCloudMessaging_Listeners();
  }

  void firebaseCloudMessaging_Listeners() {
    if (Platform.isIOS) iOS_Permission();

    _firebaseMessaging.getToken().then((token) {
      print(token);
    });

    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) {
        print('on message $message');
        _setNotifica(message.toString());
      },
      onResume: (Map<String, dynamic> message) {
        print('on resume $message');
        _setNotifica(message.toString());
      },
      onLaunch: (Map<String, dynamic> message) {
        print('on launch $message');
        _setNotifica(message.toString());
      },
    );
  }

  void iOS_Permission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  @override
  Widget build(BuildContext context) {
    _getNotificheCount();
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: ncount<=0? new Icon(Icons.notifications): new Stack(
                children: <Widget>[
                  new Icon(Icons.notifications),
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
              leading: Icon(Icons.music_note),
              title: Text('Miserere'),
              subtitle: Text('Il salmo 50'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/salmo');
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('Programma Quaresima 2019'),
              subtitle: Text('Parrocchia San Michele Arcangelo'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/programma');
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Confraternite'),
              subtitle: Text('Arciconfraternite e processioni'),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pushNamed(context, '/confraternite');
              },
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Cosa vedere'),
              subtitle: Text('Cosa c\'è nella prossima ora'),
              trailing: Icon(Icons.chevron_right),
            ),
          ],
        ),
      ),
      onWillPop: () {
        return showDialog(
              context: context,
              builder: (context) => new AlertDialog(
                    title: new Text('Sei sicuro?'),
                    content:
                        new Text('Vuoi davvero chiudere l \'app Miserere?'),
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
            ) ??
            false;
      },
    );
  }

  _getNotificheCount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifiche = (prefs.getStringList('notifiche') ?? List());
    setState(() {
      ncount=notifiche.length;
    });
  }

  _setNotifica(String notifica) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifiche = (prefs.getStringList('notifiche') ?? List());
    notifiche.add(notifica);
    await prefs.setStringList('notifiche', notifiche);
  }
}
