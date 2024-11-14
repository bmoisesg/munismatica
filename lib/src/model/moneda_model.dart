class MonedaModel {
  final String anio;
  final String fechaIngreso;

  MonedaModel({
    required this.anio,
    required this.fechaIngreso,
  });

  factory MonedaModel.fromMap(Map<dynamic, dynamic> map) {
    return MonedaModel(
      anio: map['año'] ?? '',
      fechaIngreso: map['fecha_ingreso'] ?? '',
    );
  }
}
