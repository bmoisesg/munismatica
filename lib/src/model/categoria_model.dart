class CategoriaModel {
  final String id;
  final String titulo;

  CategoriaModel({
    required this.id,
    required this.titulo,
  });

  factory CategoriaModel.fromMap(Map<dynamic, dynamic> map, String id) {
    return CategoriaModel(
      id: id,
      titulo: map['categoria'] ?? '',
    );
  }
}
