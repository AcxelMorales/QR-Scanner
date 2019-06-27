import 'package:latlong/latlong.dart';

class ScannModel {
  int id;
  String tipo;
  String valor;

  ScannModel({
    this.id,
    this.tipo,
    this.valor,
  }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  factory ScannModel.fromJson(Map<String, dynamic> json) => new ScannModel(
    id: json["id"],
    tipo: json["tipo"],
    valor: json["valor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "tipo": tipo,
    "valor": valor,
  };

  LatLng getLatLng() {
    final latlng = valor.substring(4).split(',');
    final lat = double.parse(latlng[0]);
    final lng = double.parse(latlng[1]);

    return LatLng(lat, lng);
  }
}
