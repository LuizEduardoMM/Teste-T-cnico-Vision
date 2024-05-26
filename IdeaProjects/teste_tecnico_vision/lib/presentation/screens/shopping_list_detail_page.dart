import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/presentation/widgets/custom_app_bar_cart.dart';
import 'package:teste_tecnico_vision/presentation/screens/insert_itens_screen.dart';
import '../../models/itens.dart';

class ShoppingListDetailPage extends StatefulWidget {
  final ListaCompras shoppingList;

  ShoppingListDetailPage({required this.shoppingList});

  @override
  _ShoppingListDetailPageState createState() => _ShoppingListDetailPageState();
}

class _ShoppingListDetailPageState extends State<ShoppingListDetailPage> {
  final TextEditingController controller = TextEditingController();
  String searchTerm = '';

  void _navigateToProductCreationPage() {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => ProductCreationPage(shoppingList: widget.shoppingList),
      ),
    )
        .then((value) {
      debugPrint('Supostamente sou o 3');
      BlocProvider.of<ShoppingListBloc>(context).add(CarregarListaCompra());
    });
  }

  void _removeProduct(Item item) {
    BlocProvider.of<ShoppingListBloc>(context)
        .add(RemoverProdutoListaCompra(widget.shoppingList.nome, item));
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, List<Item>> categorizedItems = {};
    for (var item in widget.shoppingList.itens) {
      if (!categorizedItems.containsKey(item.categoria)) {
        categorizedItems[item.categoria] = [];
      }
      categorizedItems[item.categoria]!.add(item);
    }

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: CustomAppBarCart(),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(23),
            topRight: Radius.circular(23),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
              child: Text(
                'Criada em ${widget.shoppingList.dataCriacao.toLocal().toShortDateString()}',
                style: const TextStyle(
                  color: Colors.black,
                  fontFamily: 'Brutel',
                  fontSize: 13,
                ),
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_outlined),
                    style: const ButtonStyle(
                      visualDensity: VisualDensity(horizontal: -4.0, vertical: -4.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Text(
                    widget.shoppingList.nome,
                    style: const TextStyle(
                      color: Colors.black,
                      fontFamily: 'Brutel',
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                      child: Row(
                        children: [
                          Text("Produtos (${widget.shoppingList.itens.length})",
                              style: const TextStyle(
                                color: Colors.black,
                                fontFamily: 'Brutel',
                                fontSize: 14,
                              )),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              child: Text(
                                "Total: R\$${(widget.shoppingList.itens.fold<double>(0.0, (sum, item) => sum + (item.preco ?? 0.0) * item.quantidade)).toStringAsFixed(2)}",
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: TextField(
                        controller: controller,
                        onChanged: (value) {
                          setState(() {
                            searchTerm = value;
                          });
                        },
                        decoration: InputDecoration(
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                color: Colors.yellow,
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.add, size: 16),
                                color: Colors.white,
                                onPressed: _navigateToProductCreationPage,
                              ),
                            ),
                          ),
                          hintText: 'Nome do produto',
                          hintStyle: const TextStyle(
                            color: Colors.grey,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ),
                    ...categorizedItems.entries.map((entry) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.key,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: 'Brutel',
                              ),
                            ),
                            ...entry.value.map((item) {
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ListTile(
                                  title: Text(item.nome),
                                  subtitle: Text(
                                    'Quantidade: ${item.quantidade} | Unidade: R\$${(item.preco ?? 0.0).toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontFamily: 'Brutel',
                                    ),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      item.preco != null
                                          ? Text('Total: R\$${((item.preco ?? 0.0) * item.quantidade).toStringAsFixed(2)}')
                                          : Container(),
                                      IconButton(
                                        icon: Icon(Icons.delete, color: Colors.red),
                                        onPressed: () => _removeProduct(item),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}';
  }
}
