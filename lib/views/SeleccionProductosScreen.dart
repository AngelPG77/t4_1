import 'package:flutter/material.dart';
import 'package:t4_1/models/PedidoDetalle.dart';
import 'package:t4_1/viewModels/SeleccionViewModel.dart';

class SeleccionProductosScreen extends StatefulWidget {
  final List<PedidoDetalle>? seleccionPrevia;

  const SeleccionProductosScreen({super.key, this.seleccionPrevia});

  @override
  State<SeleccionProductosScreen> createState() =>
      _SeleccionProductosScreenState();
}

class _SeleccionProductosScreenState extends State<SeleccionProductosScreen> {
  final SeleccionViewmodel viewModel = SeleccionViewmodel();

  @override
  void initState() {
    super.initState();
    if (widget.seleccionPrevia != null) {
      viewModel.cargarSeleccionPrevia(widget.seleccionPrevia!);
    }
    viewModel.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    viewModel.dispose();
    super.dispose();
  }

  void _confirmarSeleccion() {
    Navigator.pop(context, viewModel.seleccion);
  }

  void _cancelarSeleccion() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selección de Productos'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.catalogo.length,
              itemBuilder: (context, index) {
                final producto = viewModel.catalogo[index];
                final cantidad = viewModel.cantidadActual(producto);
                final estaSeleccionado = cantidad > 0;
                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  color: estaSeleccionado ? colorScheme.primaryContainer : colorScheme.surfaceContainerLow,
                  child: ListTile(
                    title: Text(
                      producto.nombre,
                      style: TextStyle(
                        fontWeight: estaSeleccionado
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: estaSeleccionado
                            ? colorScheme.onPrimaryContainer
                            : colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      '${producto.precio.toStringAsFixed(2)} €',
                      style: TextStyle(
                        color: estaSeleccionado 
                             ? colorScheme.onPrimaryContainer.withOpacity(0.7)
                             : colorScheme.onSurfaceVariant,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (estaSeleccionado)
                          IconButton(
                            icon: Icon(
                              Icons.remove_circle_outline,
                              color: colorScheme.error,
                            ),
                            onPressed: () => viewModel.removeProducto(producto),
                          ),
                        if (estaSeleccionado)
                          Text(
                            '$cantidad',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outline,
                            color: colorScheme.primary,
                          ),
                          onPressed: () => viewModel.addProducto(producto),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainer,
              boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: colorScheme.shadow.withOpacity(0.15),
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Row(
              children: [
                Text(
                  '${viewModel.seleccion.length} items',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.bold
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: _cancelarSeleccion,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: colorScheme.onSurfaceVariant,
                    side: BorderSide(color: colorScheme.outline),
                  ),
                  child: const Text('Cancelar'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: viewModel.seleccion.isEmpty
                      ? null
                      : _confirmarSeleccion,
                  child: const Text('CONFIRMAR'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}