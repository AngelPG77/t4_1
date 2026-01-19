/// Modelo que representa un producto con su id, nombre y precio.
class Producto {
  /// Identificador único del producto.
  final String id;
  /// Nombre del producto.
  final String nombre;
  /// Precio del producto.
  final double precio;

  /// Constructor para inicializar un producto con su id, nombre y precio.
  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
  });


}