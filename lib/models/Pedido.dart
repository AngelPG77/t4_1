import 'package:t4_1/models/PedidoDetalle.dart';


class Pedido {

  final String mesa;
  final List<PedidoDetalle> productos;

  Pedido({
    required this.mesa,
    required this.productos,
  });

  double get total {
    double suma = 0.0;
    for (var producto in productos) {
      suma += producto.totalPrecio; 
    }
    return suma;
  }

  int get totalProductos {
    int cantidad = 0;
    for (var producto in productos) {
      cantidad += producto.cantidad;
    }
    return cantidad;
  }
  
}