class BilleteModel {
  final String anio;
  final String fechaIngreso;

  BilleteModel({
    required this.anio,
    required this.fechaIngreso,
  });

  factory BilleteModel.fromMap(Map<dynamic, dynamic> map) {
    return BilleteModel(
      anio: map['año'] ?? '',
      fechaIngreso: map['fecha_ingreso'] ?? '',
    );
  }
}
