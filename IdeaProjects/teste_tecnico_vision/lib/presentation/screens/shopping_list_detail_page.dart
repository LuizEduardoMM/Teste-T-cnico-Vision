import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teste_tecnico_vision/models/lista.dart';
import 'package:teste_tecnico_vision/models/itens.dart';
import 'package:teste_tecnico_vision/presentation/widgets/custom_app_bar_cart.dart';
import 'package:teste_tecnico_vision/presentation/screens/insert_itens_screen.dart';
import 'package:teste_tecnico_vision/presentation/widgets/dialog_clean_list.dart';
import 'package:teste_tecnico_vision/presentation/widgets/product_categories.dart';
import 'package:teste_tecnico_vision/controller/shopping_list_controller.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_bloc.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compras_evento.dart';
import 'package:teste_tecnico_vision/blocs/listaCompras/lista_compra_estado.dart';

class ShoppingListDetailPage extends StatelessWidget {
  final ListaCompras shoppingList;
  final ShoppingListController controller = Get.put(ShoppingListController());

  ShoppingListDetailPage({required this.shoppingList});

  void _navigateToProductCreationPage(BuildContext context) {
    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (context) => ProductCreationPage(shoppingList: shoppingList),
      ),
    )
        .then((value) {
      BlocProvider.of<ShoppingListBloc>(context).add(CarregarListaCompra());
    });
  }

  Map<String, List<Item>> _categorizeItems(List<Item> items) {
    final Map<String, List<Item>> categorizedItems = {};
    for (var item in items) {
      if (!categorizedItems.containsKey(item.categoria)) {
        categorizedItems[item.categoria] = [];
      }
      categorizedItems[item.categoria]!.add(item);
    }
    return categorizedItems;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateCategorizedItems(_categorizeItems(shoppingList.itens));

    return Scaffold(
      backgroundColor: Colors.amber,
      appBar: CustomAppBarCart(),
      body: BlocConsumer<ShoppingListBloc, ShoppingListState>(
        listener: (context, state) {
          final updatedShoppingList = state.listaCompras.firstWhere(
              (list) => list.nome == shoppingList.nome,
              orElse: () => shoppingList);
          controller.updateCategorizedItems(
              _categorizeItems(updatedShoppingList.itens));
        },
        builder: (context, state) {
          return Container(
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
                    'Criada em ${shoppingList.dataCriacao.toLocal().toShortDateString()}',
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
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                        shoppingList.nome,
                        style: const TextStyle(
                          color: Colors.black,
                          fontFamily: 'Brutel',
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(120, 0, 0, 0),
                      child: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                        showDialog(context: context, builder: (context)=>DialogCleanList(shoppingList: shoppingList));
                        },
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 20, 0, 0),
                  child: Row(
                    children: [
                      Obx(() {
                        return Text(
                          "Produtos (${controller.totalItems.value})",
                          style: const TextStyle(
                            color: Colors.black,
                            fontFamily: 'Brutel',
                            fontSize: 14,
                          ),
                        );
                      }),
                      Expanded(
                        child: Obx(() {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            child: Text(
                              "Total: R\$${controller.totalPrice.value.toStringAsFixed(2)}",
                              textAlign: TextAlign.right,
                            ),
                          );
                        }),
                      ),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          switch (value) {
                            case 'Nome (A-Z)':
                              controller.sortItemsByName(true);
                              break;
                            case 'Nome (Z-A)':
                              controller.sortItemsByName(false);
                              break;
                            case 'Preço (Crescente)':
                              controller.sortItemsByPrice(true);
                              break;
                            case 'Preço (Decrescente)':
                              controller.sortItemsByPrice(false);
                              break;
                          }
                        },
                        itemBuilder: (BuildContext context) {
                          return [
                            const PopupMenuItem(
                              value: 'Nome (A-Z)',
                              child: Text('Nome (A-Z)'),
                            ),
                            const PopupMenuItem(
                              value: 'Nome (Z-A)',
                              child: Text('Nome (Z-A)'),
                            ),
                            const PopupMenuItem(
                              value: 'Preço (Crescente)',
                              child: Text('Preço (Crescente)'),
                            ),
                            const PopupMenuItem(
                              value: 'Preço (Decrescente)',
                              child: Text('Preço (Decrescente)'),
                            ),
                          ];
                        },
                        icon: const Icon(Icons.sort),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: TextField(
                            controller: TextEditingController(),
                            onChanged: (value) {
                              controller.updateSearchTerm(value);
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0)),
                              hintText: 'Nome do produto',
                              hintStyle: const TextStyle(
                                color: Colors.grey,
                              ),
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
                                    onPressed: () =>
                                        _navigateToProductCreationPage(context),
                                    icon: const Icon(
                                      Icons.add,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Obx(() {
                          return Column(
                            children: controller.categorizedItems.entries
                                .map((entry) {
                              return ProductCategory(
                                category: entry.key,
                                items: entry.value,
                                onRemoveProduct: (item) {
                                  controller.removeProduct(entry.key, item);
                                  BlocProvider.of<ShoppingListBloc>(context)
                                      .add(RemoverProdutoListaCompra(
                                          shoppingList.nome, item));
                                },
                              );
                            }).toList(),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

extension on DateTime {
  String toShortDateString() {
    return '${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}';
  }
}
