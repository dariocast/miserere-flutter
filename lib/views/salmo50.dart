import 'package:flutter/material.dart';
import 'package:miserere/widgets/audioWidget.dart';
const kUrl = "http://dariocast.altervista.org/miserere/files/miserere.mp3";


class Salmo50 extends StatelessWidget {
  static const routeName = '/salmo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Il Salmo 50'),
      ),
      body: Center(
        child: AudioWidget(kUrl),
      ),
    );
  }
}