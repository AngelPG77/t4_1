import 'package:flutter/material.dart';
import 'package:t4_1/models/Pedido.dart';
import 'package:t4_1/viewModels/HomeViewModel.dart';
import 'package:t4_1/views/CrearPedidoScreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeViewmodel viewModel = HomeViewmodel();

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
    super.dispose();
  }

  void _irCrearPedido() async {
    final resultado = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CrearPedidoScreen()),
    );

    if (!mounted) return;

    if (resultado != null && resultado is Pedido) {
      viewModel.addPedido(resultado);
    }
  }

  void _verResumenPedido(Pedido pedidoSeleccionado) {
    Navigator.pushNamed(
      context,
      '/resumenPedido',
      arguments: pedidoSeleccionado,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('CLAROBOBA'),
        backgroundColor: colorScheme.inversePrimary,
        foregroundColor: colorScheme.onSurface,
      ),
      body: viewModel.getPedidos().isEmpty
          ? Center(
              child: Text(
                'No hay pedidos activos',
                style: TextStyle(
                  color: colorScheme.onSurfaceVariant,
                  fontSize: 16,
                ),
              ),
            )
          : ListView.builder(
              itemCount: viewModel.getPedidos().length,
              itemBuilder: (context, index) {
                final pedido = viewModel.getPedidos()[index];
                return Card(
                  elevation: 2,
                  shadowColor: colorScheme.shadow.withOpacity(0.2),
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: ListTile(
                    onTap: () => _verResumenPedido(pedido),
                    leading: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size:
                              62, 
                          color: colorScheme.primaryContainer,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Text(
                            '${index + 1}',
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
                      pedido.mesa,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    subtitle: Text(
                      '${pedido.totalProductos} productos',
                      style: TextStyle(color: colorScheme.onSurfaceVariant),
                    ),
                    trailing: Text(
                      '${pedido.total.toStringAsFixed(2)} €',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _irCrearPedido,
        label: const Text('Nuevo Pedido'),
        icon: Icon(Icons.add, color: colorScheme.onPrimaryContainer),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
    );
  }
}
