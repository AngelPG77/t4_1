import 'package:flutter/material.dart';
import 'package:t4_1/models/PedidoDetalle.dart';
import 'package:t4_1/models/Producto.dart';

/// ViewModel que gestiona la selección de productos en la pantalla de pedidos.
/// 
/// Responsabilidades:
/// - Mantener el catálogo de productos disponibles
/// - Gestionar la lista de productos seleccionados con sus cantidades
/// - Permitir agregar y eliminar productos de la selección
/// - Obtener la cantidad actual de un producto seleccionado
/// - Cargar una selección previa (para editar pedidos)
class SeleccionViewmodel extends ChangeNotifier {

  /// Catálogo completo de productos disponibles en el bar con nombre y precio.
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

  /// Lista de productos que el usuario ha seleccionado junto con sus cantidades.
  final List<PedidoDetalle> _seleccion = [];
  
  List<PedidoDetalle> get seleccion => _seleccion;

  /// Añade un producto al pedido o incrementa su cantidad si ya existe.
  void addProducto(Producto producto) {
    // Busca si el producto ya existe en la selección
    final index = _seleccion.indexWhere((e) => e.producto.id == producto.id);
    if (index != -1) {
      // Si existe, incrementa su cantidad
      _seleccion[index] = PedidoDetalle(
        producto: producto,
        cantidad: _seleccion[index].cantidad + 1,
      );
    } else {
      // Si no existe, lo añade con cantidad 1
      _seleccion.add(PedidoDetalle(producto: producto, cantidad: 1));
    }
    // Notifica a los listeners sobre el cambio para actualizar la UI
    notifyListeners();
}

  /// Elimina un producto del pedido o decrementa su cantidad si es mayor que 1.
  void removeProducto(Producto producto) {
    final index = _seleccion.indexWhere((e) => e.producto.id == producto.id);
    if (index != -1) {
      final cantidadActual = _seleccion[index].cantidad;
      if (cantidadActual > 1) {
        // Si hay más de 1, solo reduce la cantidad
        _seleccion[index] = PedidoDetalle(
          producto: producto,
          cantidad: cantidadActual - 1,
        );
      } else {
        // Si es la última unidad, elimina el producto completamente
        _seleccion.removeAt(index);
      }
      // Notifica a los listeners sobre el cambio para actualizar la UI
      notifyListeners();
    }
  }

  /// Devuelve la cantidad actual del producto especificado en la selección.
  /// Retorna 0 si el producto no está en la lista.
  int cantidadActual(Producto producto) {
    int index = _seleccion.indexWhere((p) => p.producto.id == producto.id);
    return index != -1 ? _seleccion[index].cantidad : 0;
  }

  /// Carga una selección previa de productos en el ViewModel.
  /// Útil para editar un pedido existente sin perder los datos previos.
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