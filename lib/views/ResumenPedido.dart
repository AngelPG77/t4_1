import 'package:flutter/material.dart';
import 'package:t4_1/models/Pedido.dart';

class ResumenPedido extends StatelessWidget {
  const ResumenPedido({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    final pedido = ModalRoute.of(context)!.settings.arguments as Pedido;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del Pedido'),
        backgroundColor: colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              title: Text(
                'Mesa: ',
                style: TextStyle(color: colorScheme.secondary),
              ),
              subtitle: Text(
                pedido.mesa,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: pedido.productos.length,
                itemBuilder: (context, index) {
                  final item = pedido.productos[index];
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
                    title: Text(item.producto.nombre),
                    trailing: Text('${item.totalPrecio.toStringAsFixed(2)} €', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ), ),
                  );
                },
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'TOTAL A PAGAR:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${pedido.total.toStringAsFixed(2)} €',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Volver a Editar'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
