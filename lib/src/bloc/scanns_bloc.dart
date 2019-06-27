import 'dart:async';

import 'package:qrreadapp/src/bloc/validators.dart';
import 'package:qrreadapp/src/providers/db_provider.dart';

class ScannsBloc with Validators {
  static final ScannsBloc _singleton = new ScannsBloc._internal();

  factory ScannsBloc() {
    return _singleton;
  }

  ScannsBloc._internal() {
    // Obtener scanns de la DB
    getScanns();
  }

  final _scannsStreamController = new StreamController<List<ScannModel>>.broadcast();

  Stream<List<ScannModel>> get scannsStream => _scannsStreamController.stream.transform(validateGeo);
  Stream<List<ScannModel>> get scannsStreamHttp => _scannsStreamController.stream.transform(validateHttp);

  dispose() {
    _scannsStreamController?.close();
  }

  getScanns() async {
    _scannsStreamController.sink.add(await DBProvider.db.getAll());
  }

  addScann(ScannModel model) async {
    await DBProvider.db.insertScann(model);
    getScanns();
  }

  deleteScann(int id) async {
    await DBProvider.db.deleteScann(id);
    getScanns();
  }

  deleteAllScanns() async {
    await DBProvider.db.deleteAll();
    getScanns();
  }
}