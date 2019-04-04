import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificheView extends StatefulWidget {
  static const routeName = '/notifiche';

  NotificheView({Key key}) : super(key: key);

  @override
  _NotificheState createState() => _NotificheState();
}

class _NotificheState extends State<NotificheView>{
  List<String> listaNotifiche = List();

  @override
  Widget build(BuildContext context) {
    _getNotifiche();
    if (listaNotifiche.length > 0) {
      return ListView.builder(
          itemCount: listaNotifiche.length,
          itemBuilder: (BuildContext ctxt, int index) {
            return new ListTile(
              title: Text(listaNotifiche[index]),
              trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () => listaNotifiche.removeAt(index)),
            );
          });
    } else {
      return Center(
        child: Text("Nessuna notifica"),
      );
    }
  }

  _getNotifiche() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> notifiche = (prefs.getStringList('notifiche') ?? List());
    setState(() {
      listaNotifiche=notifiche;
    });
  }
}
