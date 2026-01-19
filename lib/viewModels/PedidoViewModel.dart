import 'package:flutter/material.dart';
import 'package:t4_1/models/PedidoDetalle.dart';

class PedidoViewModel extends ChangeNotifier {


  String _mesa = '';
  final List<PedidoDetalle> _cuenta = [];
  
  String get mesa => _mesa;
  
  List<PedidoDetalle> get cuenta => _cuenta;

  void setMesa(String valor) {
    _mesa = valor;
    notifyListeners(); 
  }

  void reemplazarCuenta(List<PedidoDetalle> nuevaLista) {
    _cuenta.clear(); 
    _cuenta.addAll(nuevaLista); 
    notifyListeners();
  }

  double calcularTotal() {
    double total = 0.0;
    for (var item in _cuenta) {
      total += item.totalPrecio; 
    }
    return total;
  }

  bool validarPedido() {
    return _mesa.trim().isNotEmpty && _cuenta.isNotEmpty;
  }

  void limpiar() {
    _mesa = '';
    _cuenta.clear();
    notifyListeners();
  }
  
}