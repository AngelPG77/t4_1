import 'package:t4_1/models/Producto.dart';

/// Modelo que representa un artículo específico dentro de un pedido.
/// 
/// Relaciona un Producto con una cantidad concreta. (2 Sopas de Patata")
/// 
/// Permite manejar diferentes cantidades del mismo producto en un mismo pedido.
class PedidoDetalle {
  /// Producto asociado al detalle del pedido.
  /// Contiene los datos básicos del producto (id, nombre, precio).
  final Producto producto;
  
  /// Cantidad de unidades de este producto en el pedido.
  int cantidad;

  /// Constructor para inicializar el detalle del pedido con un producto y una cantidad.
  /// 
  /// La cantidad tiene un valor por defecto de 1 si no se especifica.
  PedidoDetalle({
    required this.producto,
    this.cantidad = 1,
  });

  /// Calcula el precio total de este detalle multiplicando el precio unitario por la cantidad.
  /// 
  /// Ejemplo: Si el producto cuesta 8.5€ y la cantidad es 2, retorna 17.0€.
  double get totalPrecio {
    return producto.precio * cantidad;
  }

}