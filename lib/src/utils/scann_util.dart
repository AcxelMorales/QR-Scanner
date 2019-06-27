import 'package:flutter/material.dart';

import 'package:qrreadapp/src/providers/db_provider.dart';

import 'package:url_launcher/url_launcher.dart';

openScann(BuildContext context, ScannModel model) async {
  if (model.tipo == 'http') {
    if (await canLaunch(model.valor)) {
      await launch(model.valor);
    } else {
      throw 'Could not launch ${model.valor}';
    }
  } else {
    Navigator.pushNamed(context, 'mapa', arguments: model);
  }
}
