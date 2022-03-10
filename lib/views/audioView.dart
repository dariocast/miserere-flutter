import 'package:flutter/material.dart';
import 'package:miserere/widgets/audioWidget.dart';

const kUrl = "http://dariocast.altervista.org/miserere/files/miserere.mp3";

class AudioView extends StatelessWidget {
  static const routeName = '/audio';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Miserere, il Salmo 50'),
        ),
        body: Center(
          child: Container(),
          // child: AudioWidget(kUrl),
        ));
  }
}
