import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/models/PedidoDetalle.dart';
import 'package:flutter/material.dart';
import 'package:t4_1/models/Producto.dart';

/// Gestiona los pedidos que se muestran en la vista principal.
class HomeViewmodel extends ChangeNotifier {
  /// Datos de ejemplo de pedidos. Se mostrarán en la vista principal.
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

  /// Devuelve la lista de pedidos actuales.
  List<Pedido> getPedidos() {
    return _pedidos;
  }

  /// Añade un nuevo pedido a la lista y notifica a los Listeners.
  void addPedido(Pedido pedido) {
    _pedidos.add(pedido);
    notifyListeners();
  }

}