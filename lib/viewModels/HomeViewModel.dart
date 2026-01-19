import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/models/PedidoDetalle.dart';
import 'package:flutter/material.dart';
import 'package:t4_1/models/Producto.dart';

class HomeViewmodel extends ChangeNotifier {

  final List<Pedido> _pedidos = [
    Pedido(
      mesa: 'Mesa 1',
      productos: [
        PedidoDetalle(producto: Producto(id: '1', nombre: 'Doble Cheese Burger', precio: 8.5), cantidad: 2),
        PedidoDetalle(producto: Producto(id: '3', nombre: 'Coca Cola', precio: 2.5), cantidad: 5),
      ],
    ),
    Pedido(
      mesa: 'Mesa 2',
      productos: [
        PedidoDetalle(producto: Producto(id: '2', nombre: 'Patatas Fritas con 6 salsas', precio: 5.5), cantidad: 1),
        PedidoDetalle(producto: Producto(id: '4', nombre: 'Agua Bezoya', precio: 1.0), cantidad: 3),
        PedidoDetalle(producto: Producto(id: '6', nombre: 'Tarta de queso', precio: 5.5), cantidad: 2),
      ],
    ),
  ];

  List<Pedido> getPedidos() {
    return _pedidos;
  }

  double get precioTotal {
    double total = 0.0;
    for (var pedido in _pedidos) {
      total += pedido.total;
    }
    return total;
  }

  void addPedido(Pedido pedido) {
    _pedidos.add(pedido);
    notifyListeners();
  }

}