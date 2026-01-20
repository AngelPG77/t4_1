import 'package:flutter/material.dart';
import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/models/PedidoDetalle.dart';
import 'package:t4_1/viewModels/PedidoViewModel.dart';
import 'package:t4_1/views/SeleccionProductosScreen.dart';

class CrearPedidoScreen extends StatefulWidget {
  const CrearPedidoScreen({super.key});

  @override
  State<CrearPedidoScreen> createState() => _CrearPedidoScreenState();
}

class _CrearPedidoScreenState extends State<CrearPedidoScreen> {
  final PedidoViewModel viewModel = PedidoViewModel();
  final TextEditingController _mesaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    _mesaController.dispose();
    super.dispose();
  }

  void _irSeleccionarProductos() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            SeleccionProductosScreen(seleccionPrevia: viewModel.cuenta),
      ),
    );

    if (!mounted) return;

    if (resultado != null && resultado is List<PedidoDetalle>) {
      viewModel.reemplazarCuenta(resultado);
    }
  }

   void _verResumenPedido(Pedido pedidoSeleccionado) {
    Navigator.pushNamed(
      context,
      '/resumenPedido',
      arguments: pedidoSeleccionado,
    );
  }


  void _limpiarTodo() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '¿Limpiar pedido?',
          style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        ),
        content: Text(
          'Se borrarán todos los productos y el nombre de la mesa.',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _mesaController.clear();
              viewModel.limpiar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Pedido reiniciado',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  backgroundColor: Theme.of(context).colorScheme.errorContainer,
                ),
              );
            },
            child: Text(
              'LIMPIAR',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  void _guardarPedido() {
    final colorScheme = Theme.of(context).colorScheme;
    if (viewModel.validarPedido()) {
      final pedidoFinal = Pedido(
        mesa: viewModel.mesa,
        productos: viewModel.cuenta,
      );
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Pedido guardado - ${pedidoFinal.totalProductos} artículo${pedidoFinal.totalProductos > 1 ? 's' : ''} en ${pedidoFinal.mesa}',
            style: TextStyle(
              color: colorScheme.onPrimaryContainer,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: colorScheme.primaryContainer,
          duration: const Duration(milliseconds: 1200),
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
        ),
      );
      Navigator.pop(context, pedidoFinal);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error: Debes indicar una mesa y añadir productos.',
            textAlign: TextAlign.center,
            style: TextStyle(color: colorScheme.onErrorContainer,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: colorScheme.errorContainer,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Pedido'),
        backgroundColor: colorScheme.inversePrimary,
        actions: [
          Tooltip(
            message: 'Limpiar todo',
            child: IconButton(
              icon: Icon(Icons.delete_sweep, color: colorScheme.primary),
              onPressed:
                  viewModel.cuenta.isNotEmpty || _mesaController.text.isNotEmpty
                  ? _limpiarTodo
                  : null,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _mesaController,
              decoration: InputDecoration(
                labelText: 'Mesa: ',
                labelStyle: TextStyle(color: colorScheme.secondary),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.table_bar, color: colorScheme.primary),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: colorScheme.primary, width: 2),
                ),
              ),
              onChanged: (texto) => viewModel.setMesa(texto),
            ),
          ),
          Expanded(
            child: viewModel.cuenta.isEmpty
                ? Center(
                    child: Text(
                      'Cesta vacía.\nAñade productos para empezar.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.cuenta.length,
                    itemBuilder: (context, index) {
                      final item = viewModel.cuenta[index];
                      return ListTile(
                        leading: Stack(
                          alignment: Alignment.center,
                          children: [
                            Icon(
                              Icons.star_rounded,
                              size: 62,
                              color: colorScheme.primaryContainer,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Text(
                                '${item.cantidad}',
                                style: TextStyle(
                                  color: colorScheme.onPrimaryContainer,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                        title: Text(
                          item.producto.nombre,
                          style: TextStyle(color: colorScheme.onSurface),
                        ),
                        subtitle: Text(
                          '${item.producto.precio.toStringAsFixed(2)} €/ud',
                          style: TextStyle(color: colorScheme.onSurfaceVariant),
                        ),
                        trailing: Text(
                          '${item.totalPrecio.toStringAsFixed(2)} €',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, -5),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'PRECIO TOTAL:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Text(
                      '${viewModel.calcularTotal().toStringAsFixed(2)} €',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.restaurant_menu, color: colorScheme.primary),
                        label: const Text('Productos'),
                        onPressed: _irSeleccionarProductos,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: colorScheme.surfaceContainerHigh,
                          foregroundColor: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Tooltip(
                        message: (viewModel.cuenta.isEmpty && _mesaController.text.isEmpty)
                            ? 'Debes añadir un nombre de mesa y al menos un producto'
                            : (viewModel.cuenta.isEmpty)
                            ? 'Debes añadir al menos un producto'
                            : (_mesaController.text.isEmpty)
                            ? 'Debes indicar el nombre de la mesa'
                            : '',
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: colorScheme.errorContainer,
                            foregroundColor: colorScheme.onErrorContainer,
                          ),
                          icon: Icon(
                            Icons.list_alt,
                            color: colorScheme.onErrorContainer,
                          ),
                          label: const Text('Resumen'),
                          onPressed:
                              (viewModel.cuenta.isNotEmpty &&
                                  _mesaController.text.isNotEmpty)
                              ? () => _verResumenPedido(
                                    Pedido(
                                      mesa: viewModel.mesa,
                                      productos: viewModel.cuenta,
                                    ),
                                  )
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () => Navigator.pop(context),
                        style: TextButton.styleFrom(
                          foregroundColor: colorScheme.onSurfaceVariant,
                        ),
                        child: const Text('Cancelar'),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _guardarPedido,
                        child: const Text('GUARDAR PEDIDO'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
