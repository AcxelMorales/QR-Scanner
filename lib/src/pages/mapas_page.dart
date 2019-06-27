import 'package:flutter/material.dart';

import 'package:qrreadapp/src/bloc/scanns_bloc.dart';
import 'package:qrreadapp/src/models/scann_model.dart';

import 'package:qrreadapp/src/utils/scann_util.dart' as utils;

class MapasPage extends StatelessWidget {
  final scannBloc = new ScannsBloc();

  @override
  Widget build(BuildContext context) {
    scannBloc.getScanns();

    return StreamBuilder<List<ScannModel>>(
      stream: scannBloc.scannsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ScannModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final scanns = snapshot.data;

        if (scanns.length == 0) {
          return Center(
            child: Text('No hay información'),
          );
        }

        return ListView.builder(
          itemCount: scanns.length,
          itemBuilder: (BuildContext context, int index) => Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.redAccent,
              child: Center(
                child: Text(
                  'Eliminando...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0
                  ),
                ),
              ),
            ),
            onDismissed: (direccion) {
              scannBloc.deleteScann(scanns[index].id);
            },
            child: ListTile(
              leading: Icon(
                Icons.zoom_out_map,
                color: Theme.of(context).primaryColor,
              ),
              title: Text(scanns[index].valor),
              subtitle: Text('ID: ${scanns[index].id}'),
              trailing: Icon(
                Icons.keyboard_arrow_right,
                color: Colors.grey,
              ),
              onTap: () => utils.openScann(context, scanns[index]),
            ),
          )
        );
      },
    );
  }
}
