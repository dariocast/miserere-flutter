import 'package:flutter/material.dart';
import 'package:miserere/objects/MiserereApi.dart';

class Salmo50 extends StatelessWidget {
  static const routeName = '/salmo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Il Salmo 50'),
      ),
      body: Center(
        child: Text('Miserere!!!'),
      ),
    );
  }


}