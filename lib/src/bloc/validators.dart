import 'dart:async';

import 'package:qrreadapp/src/providers/db_provider.dart';

class Validators {
  final validateGeo = StreamTransformer<List<ScannModel>, List<ScannModel>>.fromHandlers(
    handleData: (scanns, sink) {
      final geoScanns = scanns.where((s) => s.tipo == 'geo').toList();
      sink.add(geoScanns);
    }
  );

  final validateHttp = StreamTransformer<List<ScannModel>, List<ScannModel>>.fromHandlers(
    handleData: (scanns, sink) {
      final httpScanns = scanns.where((s) => s.tipo == 'http').toList();
      sink.add(httpScanns);
    }
  );
}