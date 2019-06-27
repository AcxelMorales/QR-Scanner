import 'package:flutter/material.dart';

import 'package:qrreadapp/src/pages/home_page.dart';
import 'package:qrreadapp/src/pages/mapa_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Scanner',
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: {
        'home': (BuildContext context) => HomePage(),
        'mapa': (BuildContext context) => MapaPage(),
      },
      theme: ThemeData(primaryColor: Colors.teal),
    );
  }
}
