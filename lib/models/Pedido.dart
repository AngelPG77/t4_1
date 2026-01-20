import 'package:t4_1/models/PedidoDetalle.dart';

/// Modelo que representa un pedido completo de un cliente.
/// 
/// Un pedido contiene:
/// - La información de la mesa o cliente que hace el pedido
/// - Una lista de productos con sus cantidades (PedidoDetalle)
class Pedido {
  /// Identificación de la mesa (ej: "Mesa 1", "Barra")
  /// Sirve para organizar y localizar pedidos.
  final String mesa;
  
  /// Lista de artículos en el pedido.
  /// Cada elemento es un PedidoDetalle que incluye el producto y su cantidad.
  final List<PedidoDetalle> productos;

  /// Constructor para inicializar un pedido con la mesa y los productos.
  Pedido({
    required this.mesa,
    required this.productos,
  });

  /// Calcula el total del pedido sumando los totales de cada detalle de producto.
  /// 
  /// Multiplica el precio de cada producto por su cantidad.
  /// Devuelve el monto total a cobrar por el pedido.
  double get total {
    double suma = 0.0;
    for (var producto in productos) {
      suma += producto.totalPrecio; 
    }
    return suma;
  }

  /// Calcula la cantidad total de productos (unidades) en el pedido.
  /// 
  /// Suma todas las cantidades sin importar el tipo de producto.
  int get totalProductos {
    int cantidad = 0;
    for (var producto in productos) {
      cantidad += producto.cantidad;
    }
    return cantidad;
  }
  
}