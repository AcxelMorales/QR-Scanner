import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';

import 'package:qrreadapp/src/models/scann_model.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  final MapController map = MapController();
  String typeMap = 'streets';

  @override
  Widget build(BuildContext context) {
    final ScannModel scann = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Coordenadas QR'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.my_location),
            onPressed: () {
              map.move(scann.getLatLng(), 10.0);
            },
          )
        ],
      ),
      body: _createFlutterMap(scann),
      floatingActionButton: _createButtonChage(context),
    );
  }

  Widget _createButtonChage(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        //streets, satellite, outdoors, dark, light
        if (typeMap == 'streets') {
          typeMap = 'satellite';
        } else if (typeMap == 'satellite') {
          typeMap = 'outdoors';
        } else if (typeMap == 'outdoors') {
          typeMap = 'dark';
        } else if (typeMap == 'dark') {
          typeMap = 'light';
        } else {
          typeMap = 'streets';
        }

        setState(() {});
      },
      backgroundColor: Theme.of(context).primaryColor,
      child: Icon(
        Icons.repeat,
        color: Colors.white
      ),
    );
  }

  Widget _createFlutterMap(ScannModel scann) {
    return FlutterMap(
      mapController: map,
      options: MapOptions(
        center: scann.getLatLng(),
        zoom: 10.0
      ),
      layers: [
        _createMap(),
        _createMarks(scann)
      ],
    );
  }

  _createMap() {
    return TileLayerOptions(
      urlTemplate: 'https://api.mapbox.com/v4/'
      '{id}/{z}/{x}/{y}@2x.png?access_token={accessToken}',
      additionalOptions: {
        'accessToken': 'pk.eyJ1IjoiYWN4ZWwiLCJhIjoiY2p4ZGtrM3gyMDEyYzN6b2UydWw2NzQ1bCJ9.IMpt98bhYc0Su5UC7jX8hQ',
        'id': 'mapbox.$typeMap'
      }
    );
  }

  _createMarks(ScannModel scann) {
    return MarkerLayerOptions(
      markers: <Marker>[
        Marker(
          width: 70.0,
          height: 70.0,
          point: scann.getLatLng(),
          builder: (BuildContext context) => Container(
            child: Icon(
              Icons.location_on,
              size: 70.0,
              color: Theme.of(context).primaryColor,
            ),
          )
        )
      ]
    );
  }
}
