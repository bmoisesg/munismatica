import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/model/model.dart';
import 'package:provider/provider.dart';
import 'package:mi_primera_numismatica/src/utils/provider/provider.dart';

class SummaryMonedaWidget extends StatefulWidget {
  const SummaryMonedaWidget({super.key});

  @override
  State<SummaryMonedaWidget> createState() => _SummaryMonedaWidgetState();
}

class _SummaryMonedaWidgetState extends State<SummaryMonedaWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context, listen: true);
    final String nombreCategoria = provider.nombreCategoria;
    final List<MonedaModel> listaMonedas = provider.listaMonedas;
    final MonedaModel monedaFirst = provider.listaMonedaFirst;
    final MonedaModel monedaLast = provider.listaMonedaLast;
    final Map<int, List<MonedaModel>> summaryMonedas = provider.summaryMonedas;

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Categoria $nombreCategoria',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Contador: ', style: TextStyle(color: Colors.grey)),
              Text('${listaMonedas.length} Moneda(s)'),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Primera Moneda: ', style: TextStyle(color: Colors.grey)),
              Text(monedaFirst.anio),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text('Ultima Moneda: ', style: TextStyle(color: Colors.grey)),
              Text(monedaLast.anio),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(),
          Expanded(
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: summaryMonedas.entries.map((e) {
                    final Color color = e.value.isEmpty ? Colors.grey.withOpacity(0.7) : Colors.black;

                    return Row(
                      children: [
                        Text(
                          e.key.toString(),
                          style: TextStyle(color: color),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          e.value.isEmpty ? 'Sin registro' : '${e.value.length} Moneda(s)',
                          style: TextStyle(color: color),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
