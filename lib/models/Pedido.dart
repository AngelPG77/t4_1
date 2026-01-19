import 'package:t4_1/models/PedidoDetalle.dart';

/// Modelo que representa un pedido, incluye la mesa y una lista delos productos solicitados.
class Pedido {
  /// Nombre o identificador de la mesa.
  final String mesa;
  /// Lista de artículos en el pedido.
  final List<PedidoDetalle> productos;

  /// Constructor para inicializar un pedido con la mesa y los productos.
  Pedido({
    required this.mesa,
    required this.productos,
  });

  /// Calcula el total del pedido sumando los totales de cada detalle de producto.
  double get total {
    double suma = 0.0;
    for (var producto in productos) {
      suma += producto.totalPrecio; 
    }
    return suma;
  }

  /// Calcula la cantidad total de productos en el pedido.
  int get totalProductos {
    int cantidad = 0;
    for (var producto in productos) {
      cantidad += producto.cantidad;
    }
    return cantidad;
  }
  
}