import 'package:flutter/material.dart';
import 'package:t4_1/models/PedidoDetalle.dart';
import 'package:t4_1/models/Producto.dart';

class SeleccionViewmodel extends ChangeNotifier {

  final List<Producto> catalogo = [
    Producto(id: '1', nombre: 'Doble Cheese Burger', precio: 8.5),
    Producto(id: '2', nombre: 'Patatas Fritas con 6 salsas', precio: 5.5),
    Producto(id: '3', nombre: 'Coca Cola', precio: 2.5),
    Producto(id: '4', nombre: 'Agua Bezoya', precio: 1.0),
    Producto(id: '5', nombre: 'Pizza Margarita 30cm', precio: 10.0),
    Producto(id: '6', nombre: 'Tarta de queso', precio: 5.5),
    Producto(id: '7', nombre: 'Café', precio: 0.85),
    Producto(id: '8', nombre: 'Chuletón 800gr', precio: 48.77),
    Producto(id: '9', nombre: 'Sopa de Patata', precio: 2.0),
    Producto(id: '10', nombre: 'Arroz con mandarina', precio: 10.0)
  ];

  final List<PedidoDetalle> _seleccion = [];
  
  List<PedidoDetalle> get seleccion => _seleccion;

  void addProducto(Producto producto) {
    final index = _seleccion.indexWhere((e) => e.producto.id == producto.id);
    if (index != -1) {
      _seleccion[index] = PedidoDetalle(
        producto: producto,
        cantidad: _seleccion[index].cantidad + 1,
      );
    } else {
      _seleccion.add(PedidoDetalle(producto: producto, cantidad: 1));
    }
    notifyListeners();
}

  void removeProducto(Producto producto) {
    final index = _seleccion.indexWhere((e) => e.producto.id == producto.id);
    if (index != -1) {
      final cantidadActual = _seleccion[index].cantidad;
      if (cantidadActual > 1) {
        _seleccion[index] = PedidoDetalle(
          producto: producto,
          cantidad: cantidadActual - 1,
        );
      } else {
        _seleccion.removeAt(index);
      }
      notifyListeners();
    }
  }

int cantidadActual(Producto producto) {
    int index = _seleccion.indexWhere((p) => p.producto.id == producto.id);
    return index != -1 ? _seleccion[index].cantidad : 0;
  }

void cargarSeleccionPrevia(List<PedidoDetalle> previa) {
  _seleccion.clear();
  for (var item in previa) {
    _seleccion.add(PedidoDetalle(
      producto: item.producto, 
      cantidad: item.cantidad
    ));
  }
  notifyListeners();
}
}