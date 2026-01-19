import 'package:t4_1/models/Producto.dart';

/// Modelo que representa el detalle de pedido, incluye un producto y su cantidad.
class PedidoDetalle {
  // Producto asociado al detalle del pedido.
  final Producto producto;
  // Cantidad del producto en el pedido.
  int cantidad;

  /// Constructor para inicializar el detalle del pedido con un producto y una cantidad (por defecto 1).
  PedidoDetalle({
    required this.producto,
    this.cantidad = 1,
  });

  /// Calcula el precio total del detalle multiplicando el precio del producto por la cantidad.
  double get totalPrecio {
    return producto.precio * cantidad;
  }

}