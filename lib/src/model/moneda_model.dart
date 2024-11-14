class MonedaModel {
  final String anio;
  final String fechaIngreso;
  final String id;

  MonedaModel({
    required this.anio,
    required this.fechaIngreso,
    required this.id,
  });

  factory MonedaModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return MonedaModel(
      anio: map['año'] ?? '',
      fechaIngreso: map['fecha_ingreso'] ?? '',
      id: id,
    );
  }
}
