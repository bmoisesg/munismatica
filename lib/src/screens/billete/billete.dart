import 'package:flutter/material.dart';
import 'package:mi_primera_numismatica/src/components/button.dart';
import 'package:mi_primera_numismatica/src/screens/billete/lista.dart';

class PageBillete extends StatefulWidget {
  const PageBillete({super.key});

  @override
  State<PageBillete> createState() => _PageBilleteState();
}

class _PageBilleteState extends State<PageBillete> {
  Future<List> getData() async {
    return [
      "Q 0.50",
      "Q 1.00",
      "Q 5.00",
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Billetes'),
        elevation: 30,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text('Categorias'),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder<List>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.connectionState == ConnectionState.done) {
                    return GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        return CustomButton(
                          title: snapshot.data![index],
                          fnt: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => PageBilleteLista(valor: snapshot.data![index])),
                            );
                          },
                        );
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
