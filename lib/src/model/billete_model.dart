class BilleteModel {
  final String id;
  final String anio;
  final String fechaIngreso;

  BilleteModel({
    required this.id,
    required this.anio,
    required this.fechaIngreso,
  });

  factory BilleteModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return BilleteModel(
      id: id,
      anio: map['año'] ?? '',
      fechaIngreso: map['fecha_ingreso'] ?? '',
    );
  }
}
