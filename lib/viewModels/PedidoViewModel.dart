import 'package:flutter/material.dart';
import 'package:t4_1/models/PedidoDetalle.dart';

/// ViewModel que gestiona el estado de creación de un nuevo pedido.
/// 
/// Responsabilidades:
/// - Mantener el estado de la mesa seleccionada
/// - Gestionar la lista de productos del pedido actual
/// - Validar que el pedido sea completo antes de confirmarlo
/// - Calcular el total del pedido
class PedidoViewModel extends ChangeNotifier {

  /// Mesa asociada al pedido actual (ej: "Mesa 1", "Mesa de Sonia")
  String _mesa = '';
  
  /// Lista de artículos añadidos al pedido actual
  final List<PedidoDetalle> _cuenta = [];
  
  String get mesa => _mesa;
  
  List<PedidoDetalle> get cuenta => _cuenta;

  /// Actualiza la mesa del pedido y notifica a los listeners para redibujarse.
  void setMesa(String valor) {
    _mesa = valor;
    notifyListeners(); 
  }

  /// Reemplaza completamente la lista de productos del pedido con una nueva lista.
  /// Útil para cargar un pedido previo o sincronizar desde otra pantalla.
  void reemplazarCuenta(List<PedidoDetalle> nuevaLista) {
    _cuenta.clear(); 
    _cuenta.addAll(nuevaLista); 
    notifyListeners();
  }

  /// Calcula y devuelve el monto total del pedido actual.
  /// Suma el precio total (precio × cantidad) de cada detalle.
  double calcularTotal() {
    double total = 0.0;
    for (var item in _cuenta) {
      total += item.totalPrecio; 
    }
    return total;
  }

  /// Valida que el pedido sea válido:
  /// - La mesa no esté vacía
  /// - Haya al menos un producto en el pedido
  bool validarPedido() {
    return _mesa.trim().isNotEmpty && _cuenta.isNotEmpty;
  }

  /// Limpia completamente el pedido: vacía la mesa y la lista de productos.
  /// Se utiliza después de confirmar un pedido.
  void limpiar() {
    _mesa = '';
    _cuenta.clear();
    notifyListeners();
  }
  
}