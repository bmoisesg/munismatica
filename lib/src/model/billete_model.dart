class BilleteModel {
  final String anio;
  final String fechaIngreso;
  final String id;

  BilleteModel({
    required this.anio,
    required this.fechaIngreso,
    required this.id,
  });

  factory BilleteModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return BilleteModel(
      anio: map['año'] ?? '',
      fechaIngreso: map['fecha_ingreso'] ?? '',
      id: id,
    );
  }
}
