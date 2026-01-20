/// Modelo que representa un producto disponible en el catálogo del bar.
/// 
/// Contiene información básica del producto: identificador único, nombre y precio.
class Producto {
  /// Identificador único del producto (ej: '1', '2', etc.)
  final String id;
  
  /// Nombre del producto (ej: 'Doble Cheese Burger', 'Coca Cola')
  /// Es lo que se muestra al usuario en la interfaz.
  final String nombre;
  
  /// Precio del producto.
  /// Se utiliza para calcular el total del pedido.
  final double precio;

  /// Constructor para inicializar un producto.
  Producto({
    required this.id,
    required this.nombre,
    required this.precio,
  });
  
}