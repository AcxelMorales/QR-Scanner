import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qrcode_reader/qrcode_reader.dart';

import 'package:qrreadapp/src/bloc/scanns_bloc.dart';

import 'package:qrreadapp/src/models/scann_model.dart';

import 'package:qrreadapp/src/pages/direcciones_page.dart';
import 'package:qrreadapp/src/pages/mapas_page.dart';

import 'package:qrreadapp/src/utils/scann_util.dart' as utils;

// import 'package:qrcode_reader/qrcode_reader.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScannsBloc scannBloc = new ScannsBloc();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Scanner'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_forever,),
            onPressed: () => scannBloc.deleteAllScanns(),
          ),
        ],
      ),
      body: _callPage(this.currentIndex),
      bottomNavigationBar: _crearBottomNavigationBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () => _scannQR(context),
        backgroundColor: Theme.of(context).primaryColor,
      ),
    );
  }

  _scannQR(BuildContext context) async {
    // Respuestas
    // https://acxelmorales.github.io/Acxel-Morales
    // geo:40.7388020951835,-73.99220838984377

    String futureString = 'https://acxelmorales.github.io/Acxel-Morales';

    try {
      futureString = await new QRCodeReader().scan();
    } catch (e) {
      futureString = e.toString();
    }

    if (futureString != null) {
      final scann = ScannModel(valor: futureString);
      scannBloc.addScann(scann);

      if (Platform.isIOS) {
        Future.delayed(Duration(milliseconds: 750), () {
          utils.openScann(context, scann);
        });
      } else {
        utils.openScann(context, scann);
      }
    }
  }

  Widget _callPage(int paginaActual) {
    switch (paginaActual) {
      case 0:
        return MapasPage();
        break;
      case 1:
        return DireccionesPage();
        break;
      default:
        return MapasPage();
        break;
    }
  }

  Widget _crearBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (int index) {
        setState(() => currentIndex = index);
      },
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.map), title: Text('Mapas')),
        BottomNavigationBarItem(icon: Icon(Icons.brightness_5), title: Text('Direcciones')),
      ],
    );
  }
}
