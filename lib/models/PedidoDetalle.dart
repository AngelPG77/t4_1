import 'package:t4_1/models/Producto.dart';

class PedidoDetalle {

  final Producto producto;
  int cantidad;

  PedidoDetalle({
    required this.producto,
    this.cantidad = 1,
  });

  double get totalPrecio {
    return producto.precio * cantidad;
  }

}